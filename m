Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B75434EAF
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Oct 2021 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJTPMx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Oct 2021 11:12:53 -0400
Received: from woodpecker.gentoo.org ([140.211.166.183]:59994 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTPMw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Oct 2021 11:12:52 -0400
Message-ID: <4d9979cd-f2fb-bf65-883a-258a656c08e1@gentoo.org>
Date:   Wed, 20 Oct 2021 17:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
To:     linux-hyperv@vger.kernel.org
Content-Language: en-US
From:   Thomas Deutschmann <whissi@gentoo.org>
Organization: Gentoo Linux
Subject: hv_balloon: kmsg about unhandled message is killing the system
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

I am running a Hyper-V Gen2 VM with Gentoo Linux where I make use of the
memory ballooning feature (8192MB RAM Minimum; 61440MB RAM Maximum; 20%
memory buffer) for almost 2 years. Since kernel 5.14, the virtual
machine will sometimes log _a lot_ of

> kernel: [ 1022.277623] hv_balloon: Unhandled message: type: 0
> kernel: [ 1022.277624] hv_balloon: Unhandled message: type: 32768
> kernel: [ 1022.277625] hv_balloon: Unhandled message: type: 51200
> kernel: [ 1022.277625] hv_balloon: Unhandled message: type: 59392
> kernel: [ 1022.277689] hv_balloon: Ballooned pages: 1519104

messages, causing log mountpoint (in in my case root mountpoint) to run 
out of disk space which will kill the system in the end.

I have never seen this before with any <5.14 kernel.

Of course, I tried to bisect the kernel multiple times, but I never was
successful because it is not easy to trigger the problem. What seems to
work best:

1) After start, wait ~60 seconds for

> hv_balloon: Max. dynamic memory size: 61440 MB

message.

2) Now allocate some memory causing the VM to request more memory from 
the host system:

   $ </dev/zero head -c 22G | pv -L 256M | tail

   (Note: You have to do that slowly because host will only grant
          more memory when memory pressure is constantly high
          but when you are requesting memory too fast you will
          run out of memory)

3) Now end the process (CTRL+C) and wait until the VM has returned 
memory back to host system.

4) Now I start to compile chromium and firefox with 20 threads each in
parallel.

If the kernel is faulty, in most cases I'll see the kmsgs about
unhandled message types within 10 minutes. If I'll get the message

> hv_balloon: Balloon request will be partially fulfilled. Balloon floor reached

it's usually a sign for working kernel.

But as said at the beginning, this is not 100% reliable. I already ended
up with a kernel where I thought "This revision is fine" and suddenly 
the system died because millions of those messages were outputted. Or 
sometimes I am unable to trigger the failure again for a bad revision. 
See my last bisect attempt:

> git bisect start
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect good 62fb9874f5da54fdb243003b386128037319b219
> # bad: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
> git bisect bad 7d2a07b769330c34b4deabeed939325c77a7ec2f
> # bad: [406254918b232db198ed60f5bf1f8b84d96bca00] Merge tag 'perf-tools-for-v5.14-2021-07-01' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> git bisect bad 406254918b232db198ed60f5bf1f8b84d96bca00
> # bad: [a6eaf3850cb171c328a8b0db6d3c79286a1eba9d] Merge tag 'sched-urgent-2021-06-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad a6eaf3850cb171c328a8b0db6d3c79286a1eba9d
> # skip: [31e798fd6f0ff0acdc49c1a358b581730936a09a] Merge tag 'media/v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect skip 31e798fd6f0ff0acdc49c1a358b581730936a09a
> # good: [b981f7990e1ae61d9a48d717868df8f00f52bc08] crypto: hisilicon/hpre - register ecdh NIST P384
> git bisect good b981f7990e1ae61d9a48d717868df8f00f52bc08
> # good: [2b2142f247ebeef74aaadc1a646261c19627fd7e] spi: hisi-kunpeng: Add debugfs support
> git bisect good 2b2142f247ebeef74aaadc1a646261c19627fd7e
> # good: [72d4512e9cb14d790e361c0e085186a7ef2d2431] writeback, cgroup: split out the functional part of inode_switch_wbs_work_fn()
> git bisect good 72d4512e9cb14d790e361c0e085186a7ef2d2431
> # good: [902499937e3a82156dcb5069b6df27640480e204] mm/page_alloc: update PGFREE outside the zone lock in __free_pages_ok
> git bisect good 902499937e3a82156dcb5069b6df27640480e204
> # good: [f9ef9b82ea18e78d4cf614875a130f1a0316e645] Merge branch 'acpica'
> git bisect good f9ef9b82ea18e78d4cf614875a130f1a0316e645
> # good: [3fdc0cb59d97f87e2cc708d424f1538e31744286] arm64: smccc: Add support for SMCCCv1.2 extended input/output registers
> git bisect good 3fdc0cb59d97f87e2cc708d424f1538e31744286
> # good: [cb1b10e7ac6c1438247ee3c7e4a2f2332a77ba07] nvme-pci: remove trailing lines for helpers
> git bisect good cb1b10e7ac6c1438247ee3c7e4a2f2332a77ba07
> # good: [4b898fedeb26c4d09b83a2c5a3246a34ab99e216] media: hantro: reorder variants
> git bisect good 4b898fedeb26c4d09b83a2c5a3246a34ab99e216
> # skip: [9cd19f02c46a2dfaf70b8d450fb16f9eb246dfa4] Merge tag 'tomoyo-pr-20210628' of git://git.osdn.net/gitroot/tomoyo/tomoyo-test1
> git bisect skip 9cd19f02c46a2dfaf70b8d450fb16f9eb246dfa4
> # good: [914cde58a03cc5eef858db34687433e17d0e44be] KVM: arm64: Remove list_head from hyp_page
> git bisect good 914cde58a03cc5eef858db34687433e17d0e44be
> # good: [b4128000e2c9b176a449d748dcb083c61d61cc6e] KVM: x86: hyper-v: Prepare to check access to Hyper-V MSRs
> git bisect good b4128000e2c9b176a449d748dcb083c61d61cc6e
> # good: [a60c538ed2ff9d084544a894219eed9c5ab980e5] Merge tag 'integrity-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
> git bisect good a60c538ed2ff9d084544a894219eed9c5ab980e5
> # bad: [5e6928249b81b4d8727ab6a4037a171d15455cb0] Merge tag 'acpi-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 5e6928249b81b4d8727ab6a4037a171d15455cb0
> # good: [e17c120f48f7d86ed9fd6e44e9436d32997fd9ec] Merge tag 'array-bounds-fixes-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
> git bisect good e17c120f48f7d86ed9fd6e44e9436d32997fd9ec
> # good: [1dfb0f47aca11350f45f8c04c3b83f0e829adfa9] Merge tag 'x86-entry-2021-06-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 1dfb0f47aca11350f45f8c04c3b83f0e829adfa9
> # good: [8b457d60608aa76d7ce9c04a312669761025ba42] Merge branches 'acpi-dptf' and 'acpi-messages'
> git bisect good 8b457d60608aa76d7ce9c04a312669761025ba42
> # good: [ed562d280cb775ae4ba940bb4b81a1fbcfb303cb] Merge branches 'pm-cpufreq' and 'pm-cpuidle'
> git bisect good ed562d280cb775ae4ba940bb4b81a1fbcfb303cb
> # good: [3563f55ce65462063543dfa6a8d8c7fbfb9d7772] Merge tag 'pm-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 3563f55ce65462063543dfa6a8d8c7fbfb9d7772
> # good: [237a47ebc39de7f3763e2fd11e88774239a88b77] ACPI: NUMA: fix typo in a comment
> git bisect good 237a47ebc39de7f3763e2fd11e88774239a88b77
> # good: [4370cbf350dbaca984dbda9f9ce3fac45d6949d5] ACPI: EC: trust DSDT GPE for certain HP laptop
> git bisect good 4370cbf350dbaca984dbda9f9ce3fac45d6949d5
> # good: [ccb5ecdc2ddeaff744ee075b54cdff8a689e8fa7] ACPI: APEI: fix synchronous external aborts in user-mode
> git bisect good ccb5ecdc2ddeaff744ee075b54cdff8a689e8fa7
> # good: [120f4aa80b4cac2ae082666114a36c6c363b9df2] ACPI: NVS: fix doc warnings in nvs.c
> git bisect good 120f4aa80b4cac2ae082666114a36c6c363b9df2
> # good: [64f9111dd6225a50b8fdd365dfdda275c2a708c0] Merge branches 'acpi-ec', 'acpi-apei', 'acpi-soc' and 'acpi-misc'
> git bisect good 64f9111dd6225a50b8fdd365dfdda275c2a708c0
> # first bad commit: [5e6928249b81b4d8727ab6a4037a171d15455cb0] Merge tag 'acpi-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

For example, I booted into the bad commit 
5e6928249b81b4d8727ab6a4037a171d15455cb0 but
I am currently unable to trigger the problem again. However, 11 kernels
before I was able to trigger the problem in that revision. And I believe 
it is very unlikely that all 10 revisions between the previous failure 
are really good. So likely a problem with my testing...

Last upstream kernel I tried where I hit this was 5.14.13.


-- 
Regards,
Thomas Deutschmann / Gentoo Linux Developer
fpr: C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5
