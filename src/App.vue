<script setup lang="ts">
import { ref } from "vue"

interface Num {
    min: number
    max: number
    value: number
}

const props = defineProps({
    initialNums: {
        type: Array as () => Num[],
        default: () => []
    }
})

const nums = ref<Num[]>(props.initialNums || [])

const add_num = (min: number, max: number): void => {
    nums.value.push({
        min,
        max,
        value: Math.floor(Math.random() * (max - min + 1)) + min
    })
    roll(nums.value[length - 1])
}

const addNum6 = (): void => add_num(1, 6)

const addNum10 = (): void => add_num(0, 9)

const roll_all = async (): Promise<void> => {
    const to_run = nums.value.map((_, index) => new Promise(() => _roll(index)))
    await Promise.allSettled(to_run)
}

const sleep = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, ms))

const _roll = async (index: number): Promise<void> => {
    const num = nums.value[index]
    for (let i = 0; i < 25 + index * 25; i++) {
        num.value = Math.floor(Math.random() * (num.max - num.min + 1)) + num.min
        await sleep(10)
    }
}

const roll = async (num: Num): Promise<void> => {
    for (let i = 0; i < 25; i++) {
        num.value = Math.floor(Math.random() * (num.max - num.min + 1)) + num.min
        await sleep(10)
    }
}

const remove = (index: number): void => {
    console.log("remove index" + index)
    nums.value.splice(index, 1)
}
</script>

<template>
    <div class="fixed-btn">
        <v-btn
            v-if="nums.length !== 0"
            size="x-large"
            prepend-icon="mdi-reload"
            variant="flat"
            @click="roll_all"
        >
            RE-ROLL ALL
        </v-btn>
    </div>

    <v-container :fluid="true">
        <v-row justify="center" class="ma-16">
            <v-col
                v-for="(num, index) in nums"
                :key="index as number"
                xs="12"
                sm="6"
                md="4"
                lg="3"
                xl="2"
                xxl="1"
                class="equal-height-col"
                style="justify-content: center; display: flex"
            >
                <v-hover v-slot="{ isHovering, props }">
                    <v-card
                        :class="{ 'on-hover': isHovering, 'text-center': true }"
                        :flat="true"
                        :border="false"
                        height="200px"
                        v-bind="props"
                        width="200px"
                        @click="roll(num)"
                    >
                        <v-card-title>
                            <v-btn
                                :flat="true"
                                class="float-right"
                                :icon="isHovering ? 'mdi-close' : 'undefined'"
                                @click="
                                    (event: MouseEvent) => {
                                        remove(index)
                                        event.stopPropagation()
                                    }
                                "
                            />
                        </v-card-title>
                        <v-card-text class="text-h1 ma-6">
                            {{ num.value }}
                        </v-card-text>
                        <v-card-subtitle class="ma-6 text-center">
                            {{ num.min }}-{{ num.max }}
                        </v-card-subtitle>
                    </v-card>
                </v-hover>
            </v-col>
            <v-col
                xs="12"
                sm="6"
                md="4"
                lg="3"
                xl="2"
                xxl="1"
                class="equal-height-col"
                style="display: flex; justify-content: center"
            >
                <v-card :flat="true" height="200px" class="align-center d-flex" width="200px">
                    <v-container>
                        <v-row class="ma-2" justify="center">
                            <v-btn size="x-large" :flat="true" variant="outlined" @click="addNum6">
                                Add Num 1-6
                            </v-btn>
                        </v-row>
                        <v-row class="ma-2" justify="center">
                            <v-btn size="x-large" :flat="true" variant="outlined" @click="addNum10">
                                Add Num 0-9
                            </v-btn>
                        </v-row>
                    </v-container>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<style>
.fixed-btn {
    position: fixed;
    bottom: 0;
    right: 0;
    margin: 20px;
    z-index: 10;
}
</style>
