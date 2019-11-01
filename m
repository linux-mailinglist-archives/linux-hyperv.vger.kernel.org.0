Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE396EC54E
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2019 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfKAPIN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Nov 2019 11:08:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42771 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfKAPIN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Nov 2019 11:08:13 -0400
Received: by mail-il1-f199.google.com with SMTP id t1so69247ilp.9
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Nov 2019 08:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=g7jg7ayuHVTWvibW4AskywP9NqWduDgcoK4xyqOmH+A=;
        b=dSRwWOKY8hvoQXJTbyXCi8O6oI0AaojyG8k6bEn2upbHhxKEfHonc3p2ehTNXALHfN
         e9isRXBrHFSgstfzAzBMeOKAmd2nF1Uj8pmxGKn2NP6/bR9Z+xkwmpUAlHTueITfs15+
         MJdXwEh+hSCT4n2aErsR1T4lw+FMaLCnAaKAQs6n1GZBdbjIy3cE9tV7kzeKyRFz0boY
         54BOGuX8yuq0cX9HFNZwsGyr5zuWCBCVVBsamyuQVoNoIPhCIV8U8glXYp4mgGgOb81g
         glEGTrZu7aoT3rvDdTWwaVv7Uzm80bGmByjTwLSVk4VmhcK/ajTLZuaFJBAPvMRJ+8m6
         G4tA==
X-Gm-Message-State: APjAAAXugc0y4qi2kIb6FAFBZzteIJ1quuuMVIe/h1QhK68jn/0dUI67
        kc7KMJDcCcINyhOFzv0QMvdxMsCHB4SmwudVkuEV0VbW+61b
X-Google-Smtp-Source: APXvYqzkPx2qeeMXY0E4Fxn5xgC6XmshRku/tGEEZYY4yFnlApFzA4MngxgJdgKfbtLwgXxtUcORbnIELbHYt3yyW7L8luo7urmh
MIME-Version: 1.0
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr3820572ioh.46.1572620888990;
 Fri, 01 Nov 2019 08:08:08 -0700 (PDT)
Date:   Fri, 01 Nov 2019 08:08:08 -0700
In-Reply-To: <0000000000009ea5720595dc03a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074867b05964a559a@google.com>
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
From:   syzbot <syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com>
To:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        aroulin@cumulusnetworks.com, ast@domdv.de,
        b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org,
        cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net,
        dcaratti@redhat.com, dsa@cumulusnetworks.com, edumazet@google.com,
        f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, gvaradar@cisco.com, haiyangz@microsoft.com,
        idosch@mellanox.com, info@metux.net, ivan.khoronzhuk@linaro.org,
        j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com,
        jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us,
        johan.hedberg@gmail.com, johannes.berg@intel.com,
        john.hurley@netronome.com, jwi@linux.ibm.com,
        kstewart@linuxfoundation.org, kvalo@codeaurora.org,
        kys@microsoft.com, lariel@mellanox.com, linmiaohe@huawei.com,
        linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-wpan@vger.kernel.org, liuhangbin@gmail.com,
        marcel@holtmann.org, mareklindner@neomailbox.ch
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    49afce6d Add linux-next specific files for 20191031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163aeef4e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f119b33031056
dashboard link: https://syzkaller.appspot.com/bug?extid=692f39f040c1f415567b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173fa1f4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b68f6ce00000

The bug was bisected to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e05224e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11e05224e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e05224e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 1 PID: 421 Comm: kworker/u4:6 Not tainted 5.4.0-rc5-next-20191031 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  register_lock_class.cold+0x1b/0x27 kernel/locking/lockdep.c:1222
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  netif_addr_lock_bh include/linux/netdevice.h:4071 [inline]
  dev_uc_flush+0x1e/0x40 net/core/dev_addr_lists.c:710
  rollback_registered_many+0x903/0x10d0 net/core/dev.c:8753
  unregister_netdevice_many.part.0+0x1b/0x1f0 net/core/dev.c:9906
  unregister_netdevice_many+0x3b/0x50 net/core/dev.c:9905
  ip6gre_exit_batch_net+0x53c/0x760 net/ipv6/ip6_gre.c:1604
  ops_exit_list.isra.0+0x10c/0x160 net/core/net_namespace.c:175
  cleanup_net+0x538/0xaf0 net/core/net_namespace.c:597
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2263
  worker_thread+0x98/0xe40 kernel/workqueue.c:2409
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
kobject: 'rx-0' (00000000df096fcc): kobject_cleanup, parent 000000005ebc1b98
kobject: 'rx-0' (00000000df096fcc): auto cleanup 'remove' event
kobject: 'rx-0' (00000000df096fcc): kobject_uevent_env
kobject: 'rx-0' (00000000df096fcc): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000df096fcc): auto cleanup kobject_del
kobject: 'rx-0' (00000000df096fcc): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f21c003e): kobject_cleanup, parent 000000005ebc1b98
kobject: 'tx-0' (00000000f21c003e): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f21c003e): kobject_uevent_env
kobject: 'tx-0' (00000000f21c003e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000f21c003e): auto cleanup kobject_del
kobject: 'tx-0' (00000000f21c003e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000005ebc1b98): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000005ebc1b98): calling ktype release
kobject: 'queues' (000000005ebc1b98): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000040664ce7): kobject_uevent_env
kobject: 'ip6gre0' (0000000040664ce7): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007bcba50e): kobject_cleanup, parent 00000000a6950e4e
kobject: 'rx-0' (000000007bcba50e): auto cleanup 'remove' event
kobject: 'rx-0' (000000007bcba50e): kobject_uevent_env
kobject: 'rx-0' (000000007bcba50e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007bcba50e): auto cleanup kobject_del
kobject: 'rx-0' (000000007bcba50e): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000003f3e671b): kobject_cleanup, parent 00000000a6950e4e
kobject: 'tx-0' (000000003f3e671b): auto cleanup 'remove' event
kobject: 'tx-0' (000000003f3e671b): kobject_uevent_env
kobject: 'tx-0' (000000003f3e671b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000003f3e671b): auto cleanup kobject_del
kobject: 'tx-0' (000000003f3e671b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a6950e4e): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000a6950e4e): calling ktype release
kobject: 'queues' (00000000a6950e4e): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000f160681a): kobject_uevent_env
kobject: 'ip6gre0' (00000000f160681a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a23f6ff2): kobject_cleanup, parent 00000000ad4e5ebd
kobject: 'rx-0' (00000000a23f6ff2): auto cleanup 'remove' event
kobject: 'rx-0' (00000000a23f6ff2): kobject_uevent_env
kobject: 'rx-0' (00000000a23f6ff2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a23f6ff2): auto cleanup kobject_del
kobject: 'rx-0' (00000000a23f6ff2): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000001ee0d59b): kobject_cleanup, parent 00000000ad4e5ebd
kobject: 'tx-0' (000000001ee0d59b): auto cleanup 'remove' event
kobject: 'tx-0' (000000001ee0d59b): kobject_uevent_env
kobject: 'tx-0' (000000001ee0d59b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000001ee0d59b): auto cleanup kobject_del
kobject: 'tx-0' (000000001ee0d59b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000ad4e5ebd): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000ad4e5ebd): calling ktype release
kobject: 'queues' (00000000ad4e5ebd): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000acb58072): kobject_uevent_env
kobject: 'ip6gre0' (00000000acb58072): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fc6f68a2): kobject_cleanup, parent 000000009f4c7c01
kobject: 'rx-0' (00000000fc6f68a2): auto cleanup 'remove' event
kobject: 'rx-0' (00000000fc6f68a2): kobject_uevent_env
kobject: 'rx-0' (00000000fc6f68a2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fc6f68a2): auto cleanup kobject_del
kobject: 'rx-0' (00000000fc6f68a2): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000028c9c9c4): kobject_cleanup, parent 000000009f4c7c01
kobject: 'tx-0' (0000000028c9c9c4): auto cleanup 'remove' event
kobject: 'tx-0' (0000000028c9c9c4): kobject_uevent_env
kobject: 'tx-0' (0000000028c9c9c4): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000028c9c9c4): auto cleanup kobject_del
kobject: 'tx-0' (0000000028c9c9c4): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000009f4c7c01): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000009f4c7c01): calling ktype release
kobject: 'queues' (000000009f4c7c01): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000017406e86): kobject_uevent_env
kobject: 'ip6gre0' (0000000017406e86): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007e51ab80): kobject_cleanup, parent 0000000040ad8bc9
kobject: 'rx-0' (000000007e51ab80): auto cleanup 'remove' event
kobject: 'rx-0' (000000007e51ab80): kobject_uevent_env
kobject: 'rx-0' (000000007e51ab80): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007e51ab80): auto cleanup kobject_del
kobject: 'rx-0' (000000007e51ab80): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000a9491b56): kobject_cleanup, parent 0000000040ad8bc9
kobject: 'tx-0' (00000000a9491b56): auto cleanup 'remove' event
kobject: 'tx-0' (00000000a9491b56): kobject_uevent_env
kobject: 'tx-0' (00000000a9491b56): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000a9491b56): auto cleanup kobject_del
kobject: 'tx-0' (00000000a9491b56): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000040ad8bc9): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000040ad8bc9): calling ktype release
kobject: 'queues' (0000000040ad8bc9): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000de892406): kobject_uevent_env
kobject: 'ip6gre0' (00000000de892406): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000009d7a7acf): kobject_cleanup, parent 00000000fad31440
kobject: 'rx-0' (000000009d7a7acf): auto cleanup 'remove' event
kobject: 'rx-0' (000000009d7a7acf): kobject_uevent_env
kobject: 'rx-0' (000000009d7a7acf): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000009d7a7acf): auto cleanup kobject_del
kobject: 'rx-0' (000000009d7a7acf): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000006a2dce3c): kobject_cleanup, parent 00000000fad31440
kobject: 'tx-0' (000000006a2dce3c): auto cleanup 'remove' event
kobject: 'tx-0' (000000006a2dce3c): kobject_uevent_env
kobject: 'tx-0' (000000006a2dce3c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000006a2dce3c): auto cleanup kobject_del
kobject: 'tx-0' (000000006a2dce3c): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000fad31440): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000fad31440): calling ktype release
kobject: 'queues' (00000000fad31440): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000c8c9d4af): kobject_uevent_env
kobject: 'ip6gre0' (00000000c8c9d4af): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000671a694a): kobject_cleanup, parent 000000003f5c6e6d
kobject: 'rx-0' (00000000671a694a): auto cleanup 'remove' event
kobject: 'rx-0' (00000000671a694a): kobject_uevent_env
kobject: 'rx-0' (00000000671a694a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000671a694a): auto cleanup kobject_del
kobject: 'rx-0' (00000000671a694a): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000007e0c81b4): kobject_cleanup, parent 000000003f5c6e6d
kobject: 'tx-0' (000000007e0c81b4): auto cleanup 'remove' event
kobject: 'tx-0' (000000007e0c81b4): kobject_uevent_env
kobject: 'tx-0' (000000007e0c81b4): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000007e0c81b4): auto cleanup kobject_del
kobject: 'tx-0' (000000007e0c81b4): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000003f5c6e6d): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000003f5c6e6d): calling ktype release
kobject: 'queues' (000000003f5c6e6d): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000004c4e4277): kobject_uevent_env
kobject: 'ip6gre0' (000000004c4e4277): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002a35e203): kobject_cleanup, parent 000000006176464a
kobject: 'rx-0' (000000002a35e203): auto cleanup 'remove' event
kobject: 'rx-0' (000000002a35e203): kobject_uevent_env
kobject: 'rx-0' (000000002a35e203): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002a35e203): auto cleanup kobject_del
kobject: 'rx-0' (000000002a35e203): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f7fbcf6d): kobject_cleanup, parent 000000006176464a
kobject: 'tx-0' (00000000f7fbcf6d): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f7fbcf6d): kobject_uevent_env
kobject: 'tx-0' (00000000f7fbcf6d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000f7fbcf6d): auto cleanup kobject_del
kobject: 'tx-0' (00000000f7fbcf6d): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000006176464a): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000006176464a): calling ktype release
kobject: 'queues' (000000006176464a): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000002b00a2ed): kobject_uevent_env
kobject: 'ip6gre0' (000000002b00a2ed): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000b0877a20): kobject_cleanup, parent 00000000be2a5605
kobject: 'rx-0' (00000000b0877a20): auto cleanup 'remove' event
kobject: 'rx-0' (00000000b0877a20): kobject_uevent_env
kobject: 'rx-0' (00000000b0877a20): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000b0877a20): auto cleanup kobject_del
kobject: 'rx-0' (00000000b0877a20): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000b788c38b): kobject_cleanup, parent 00000000be2a5605
kobject: 'tx-0' (00000000b788c38b): auto cleanup 'remove' event
kobject: 'tx-0' (00000000b788c38b): kobject_uevent_env
kobject: 'tx-0' (00000000b788c38b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000b788c38b): auto cleanup kobject_del
kobject: 'tx-0' (00000000b788c38b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000be2a5605): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000be2a5605): calling ktype release
kobject: 'queues' (00000000be2a5605): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000000256280f): kobject_uevent_env
kobject: 'ip6gre0' (000000000256280f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000408ff8b5): kobject_cleanup, parent 000000009413b7d5
kobject: 'rx-0' (00000000408ff8b5): auto cleanup 'remove' event
kobject: 'rx-0' (00000000408ff8b5): kobject_uevent_env
kobject: 'rx-0' (00000000408ff8b5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000408ff8b5): auto cleanup kobject_del
kobject: 'rx-0' (00000000408ff8b5): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000009d76a43a): kobject_cleanup, parent 000000009413b7d5
kobject: 'tx-0' (000000009d76a43a): auto cleanup 'remove' event
kobject: 'tx-0' (000000009d76a43a): kobject_uevent_env
kobject: 'tx-0' (000000009d76a43a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000009d76a43a): auto cleanup kobject_del
kobject: 'tx-0' (000000009d76a43a): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000009413b7d5): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000009413b7d5): calling ktype release
kobject: 'queues' (000000009413b7d5): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000c13934a9): kobject_uevent_env
kobject: 'ip6gre0' (00000000c13934a9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000f3c207ee): kobject_cleanup, parent 00000000a94ecf37
kobject: 'rx-0' (00000000f3c207ee): auto cleanup 'remove' event
kobject: 'rx-0' (00000000f3c207ee): kobject_uevent_env
kobject: 'rx-0' (00000000f3c207ee): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000f3c207ee): auto cleanup kobject_del
kobject: 'rx-0' (00000000f3c207ee): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000000b4524b0): kobject_cleanup, parent 00000000a94ecf37
kobject: 'tx-0' (000000000b4524b0): auto cleanup 'remove' event
kobject: 'tx-0' (000000000b4524b0): kobject_uevent_env
kobject: 'tx-0' (000000000b4524b0): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000000b4524b0): auto cleanup kobject_del
kobject: 'tx-0' (000000000b4524b0): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a94ecf37): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000a94ecf37): calling ktype release
kobject: 'queues' (00000000a94ecf37): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000fe76375a): kobject_uevent_env
kobject: 'ip6gre0' (00000000fe76375a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000bea507ab): kobject_cleanup, parent 00000000269a53ac
kobject: 'rx-0' (00000000bea507ab): auto cleanup 'remove' event
kobject: 'rx-0' (00000000bea507ab): kobject_uevent_env
kobject: 'rx-0' (00000000bea507ab): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000bea507ab): auto cleanup kobject_del
kobject: 'rx-0' (00000000bea507ab): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000002b7b9170): kobject_cleanup, parent 00000000269a53ac
kobject: 'tx-0' (000000002b7b9170): auto cleanup 'remove' event
kobject: 'tx-0' (000000002b7b9170): kobject_uevent_env
kobject: 'tx-0' (000000002b7b9170): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000002b7b9170): auto cleanup kobject_del
kobject: 'tx-0' (000000002b7b9170): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000269a53ac): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000269a53ac): calling ktype release
kobject: 'queues' (00000000269a53ac): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000004e9019f2): kobject_uevent_env
kobject: 'ip6gre0' (000000004e9019f2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000003de34d47): kobject_cleanup, parent 000000005e0b5f3a
kobject: 'rx-0' (000000003de34d47): auto cleanup 'remove' event
kobject: 'rx-0' (000000003de34d47): kobject_uevent_env
kobject: 'rx-0' (000000003de34d47): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000003de34d47): auto cleanup kobject_del
kobject: 'rx-0' (000000003de34d47): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000001baeeadf): kobject_cleanup, parent 000000005e0b5f3a
kobject: 'tx-0' (000000001baeeadf): auto cleanup 'remove' event
kobject: 'tx-0' (000000001baeeadf): kobject_uevent_env
kobject: 'tx-0' (000000001baeeadf): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000001baeeadf): auto cleanup kobject_del
kobject: 'tx-0' (000000001baeeadf): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000005e0b5f3a): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000005e0b5f3a): calling ktype release
kobject: 'queues' (000000005e0b5f3a): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000ee08daa2): kobject_uevent_env
kobject: 'ip6gre0' (00000000ee08daa2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000e8a48cb0): kobject_cleanup, parent 00000000075eb5ac
kobject: 'rx-0' (00000000e8a48cb0): auto cleanup 'remove' event
kobject: 'rx-0' (00000000e8a48cb0): kobject_uevent_env
kobject: 'rx-0' (00000000e8a48cb0): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000e8a48cb0): auto cleanup kobject_del
kobject: 'rx-0' (00000000e8a48cb0): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000004a036007): kobject_cleanup, parent 00000000075eb5ac
kobject: 'tx-0' (000000004a036007): auto cleanup 'remove' event
kobject: 'tx-0' (000000004a036007): kobject_uevent_env
kobject: 'tx-0' (000000004a036007): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000004a036007): auto cleanup kobject_del
kobject: 'tx-0' (000000004a036007): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000075eb5ac): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000075eb5ac): calling ktype release
kobject: 'queues' (00000000075eb5ac): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000001c0dcda3): kobject_uevent_env
kobject: 'ip6gre0' (000000001c0dcda3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000b6130418): kobject_cleanup, parent 000000003c39afeb
kobject: 'rx-0' (00000000b6130418): auto cleanup 'remove' event
kobject: 'rx-0' (00000000b6130418): kobject_uevent_env
kobject: 'rx-0' (00000000b6130418): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000b6130418): auto cleanup kobject_del
kobject: 'rx-0' (00000000b6130418): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000002bae04b9): kobject_cleanup, parent 000000003c39afeb
kobject: 'tx-0' (000000002bae04b9): auto cleanup 'remove' event
kobject: 'tx-0' (000000002bae04b9): kobject_uevent_env
kobject: 'tx-0' (000000002bae04b9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000002bae04b9): auto cleanup kobject_del
kobject: 'tx-0' (000000002bae04b9): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000003c39afeb): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000003c39afeb): calling ktype release
kobject: 'queues' (000000003c39afeb): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000ab968d08): kobject_uevent_env
kobject: 'ip6gre0' (00000000ab968d08): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000931b5a7d): kobject_cleanup, parent 000000002ef51c00
kobject: 'rx-0' (00000000931b5a7d): auto cleanup 'remove' event
kobject: 'rx-0' (00000000931b5a7d): kobject_uevent_env
kobject: 'rx-0' (00000000931b5a7d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000931b5a7d): auto cleanup kobject_del
kobject: 'rx-0' (00000000931b5a7d): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000e9a5562a): kobject_cleanup, parent 000000002ef51c00
kobject: 'tx-0' (00000000e9a5562a): auto cleanup 'remove' event
kobject: 'tx-0' (00000000e9a5562a): kobject_uevent_env
kobject: 'tx-0' (00000000e9a5562a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000e9a5562a): auto cleanup kobject_del
kobject: 'tx-0' (00000000e9a5562a): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000002ef51c00): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000002ef51c00): calling ktype release
kobject: 'queues' (000000002ef51c00): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000f7871405): kobject_uevent_env
kobject: 'ip6gre0' (00000000f7871405): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fef07d0d): kobject_cleanup, parent 00000000b30db419
kobject: 'rx-0' (00000000fef07d0d): auto cleanup 'remove' event
kobject: 'rx-0' (00000000fef07d0d): kobject_uevent_env
kobject: 'rx-0' (00000000fef07d0d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000fef07d0d): auto cleanup kobject_del
kobject: 'rx-0' (00000000fef07d0d): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000479f1718): kobject_cleanup, parent 00000000b30db419
kobject: 'tx-0' (00000000479f1718): auto cleanup 'remove' event
kobject: 'tx-0' (00000000479f1718): kobject_uevent_env
kobject: 'tx-0' (00000000479f1718): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000479f1718): auto cleanup kobject_del
kobject: 'tx-0' (00000000479f1718): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000b30db419): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000b30db419): calling ktype release
kobject: 'queues' (00000000b30db419): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000000aa7e3fe): kobject_uevent_env
kobject: 'ip6gre0' (000000000aa7e3fe): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002594c733): kobject_cleanup, parent 000000007a89b00c
kobject: 'rx-0' (000000002594c733): auto cleanup 'remove' event
kobject: 'rx-0' (000000002594c733): kobject_uevent_env
kobject: 'rx-0' (000000002594c733): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002594c733): auto cleanup kobject_del
kobject: 'rx-0' (000000002594c733): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000b2e83822): kobject_cleanup, parent 000000007a89b00c
kobject: 'tx-0' (00000000b2e83822): auto cleanup 'remove' event
kobject: 'tx-0' (00000000b2e83822): kobject_uevent_env
kobject: 'tx-0' (00000000b2e83822): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000b2e83822): auto cleanup kobject_del
kobject: 'tx-0' (00000000b2e83822): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000007a89b00c): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000007a89b00c): calling ktype release
kobject: 'queues' (000000007a89b00c): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000ee8b6038): kobject_uevent_env
kobject: 'ip6gre0' (00000000ee8b6038): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000057d4664e): kobject_cleanup, parent 00000000cd8bcc04
kobject: 'rx-0' (0000000057d4664e): auto cleanup 'remove' event
kobject: 'rx-0' (0000000057d4664e): kobject_uevent_env
kobject: 'rx-0' (0000000057d4664e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000057d4664e): auto cleanup kobject_del
kobject: 'rx-0' (0000000057d4664e): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000d579e94e): kobject_cleanup, parent 00000000cd8bcc04
kobject: 'tx-0' (00000000d579e94e): auto cleanup 'remove' event
kobject: 'tx-0' (00000000d579e94e): kobject_uevent_env
kobject: 'tx-0' (00000000d579e94e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000d579e94e): auto cleanup kobject_del
kobject: 'tx-0' (00000000d579e94e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000cd8bcc04): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000cd8bcc04): calling ktype release
kobject: 'queues' (00000000cd8bcc04): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000053e5a548): kobject_uevent_env
kobject: 'ip6gre0' (0000000053e5a548): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000065a532bc): kobject_cleanup, parent 000000004c3594cb
kobject: 'rx-0' (0000000065a532bc): auto cleanup 'remove' event
kobject: 'rx-0' (0000000065a532bc): kobject_uevent_env
kobject: 'rx-0' (0000000065a532bc): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000065a532bc): auto cleanup kobject_del
kobject: 'rx-0' (0000000065a532bc): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000871b8eaa): kobject_cleanup, parent 000000004c3594cb
kobject: 'tx-0' (00000000871b8eaa): auto cleanup 'remove' event
kobject: 'tx-0' (00000000871b8eaa): kobject_uevent_env
kobject: 'tx-0' (00000000871b8eaa): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000871b8eaa): auto cleanup kobject_del
kobject: 'tx-0' (00000000871b8eaa): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000004c3594cb): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000004c3594cb): calling ktype release
kobject: 'queues' (000000004c3594cb): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000b0759121): kobject_uevent_env
kobject: 'ip6gre0' (00000000b0759121): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d7b62218): kobject_cleanup, parent 00000000610f56ba
kobject: 'rx-0' (00000000d7b62218): auto cleanup 'remove' event
kobject: 'rx-0' (00000000d7b62218): kobject_uevent_env
kobject: 'rx-0' (00000000d7b62218): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d7b62218): auto cleanup kobject_del
kobject: 'rx-0' (00000000d7b62218): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000a67ca687): kobject_cleanup, parent 00000000610f56ba
kobject: 'tx-0' (00000000a67ca687): auto cleanup 'remove' event
kobject: 'tx-0' (00000000a67ca687): kobject_uevent_env
kobject: 'tx-0' (00000000a67ca687): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000a67ca687): auto cleanup kobject_del
kobject: 'tx-0' (00000000a67ca687): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000610f56ba): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000610f56ba): calling ktype release
kobject: 'queues' (00000000610f56ba): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000bd0a06d6): kobject_uevent_env
kobject: 'ip6gre0' (00000000bd0a06d6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000089287da5): kobject_cleanup, parent 00000000d45afbf4
kobject: 'rx-0' (0000000089287da5): auto cleanup 'remove' event
kobject: 'rx-0' (0000000089287da5): kobject_uevent_env
kobject: 'rx-0' (0000000089287da5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000089287da5): auto cleanup kobject_del
kobject: 'rx-0' (0000000089287da5): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000006811ab10): kobject_cleanup, parent 00000000d45afbf4
kobject: 'tx-0' (000000006811ab10): auto cleanup 'remove' event
kobject: 'tx-0' (000000006811ab10): kobject_uevent_env
kobject: 'tx-0' (000000006811ab10): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000006811ab10): auto cleanup kobject_del
kobject: 'tx-0' (000000006811ab10): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000d45afbf4): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000d45afbf4): calling ktype release
kobject: 'queues' (00000000d45afbf4): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000007a0efe6b): kobject_uevent_env
kobject: 'ip6gre0' (000000007a0efe6b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000f29316ba): kobject_cleanup, parent 00000000e201f66c
kobject: 'rx-0' (00000000f29316ba): auto cleanup 'remove' event
kobject: 'rx-0' (00000000f29316ba): kobject_uevent_env
kobject: 'rx-0' (00000000f29316ba): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000f29316ba): auto cleanup kobject_del
kobject: 'rx-0' (00000000f29316ba): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000cb2d1b3f): kobject_cleanup, parent 00000000e201f66c
kobject: 'tx-0' (00000000cb2d1b3f): auto cleanup 'remove' event
kobject: 'tx-0' (00000000cb2d1b3f): kobject_uevent_env
kobject: 'tx-0' (00000000cb2d1b3f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000cb2d1b3f): auto cleanup kobject_del
kobject: 'tx-0' (00000000cb2d1b3f): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000e201f66c): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000e201f66c): calling ktype release
kobject: 'queues' (00000000e201f66c): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000ed6cd2b9): kobject_uevent_env
kobject: 'ip6gre0' (00000000ed6cd2b9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000945b59a7): kobject_cleanup, parent 00000000a107c4cd
kobject: 'rx-0' (00000000945b59a7): auto cleanup 'remove' event
kobject: 'rx-0' (00000000945b59a7): kobject_uevent_env
kobject: 'rx-0' (00000000945b59a7): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000945b59a7): auto cleanup kobject_del
kobject: 'rx-0' (00000000945b59a7): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000002e5963fd): kobject_cleanup, parent 00000000a107c4cd
kobject: 'tx-0' (000000002e5963fd): auto cleanup 'remove' event
kobject: 'tx-0' (000000002e5963fd): kobject_uevent_env
kobject: 'tx-0' (000000002e5963fd): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000002e5963fd): auto cleanup kobject_del
kobject: 'tx-0' (000000002e5963fd): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a107c4cd): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000a107c4cd): calling ktype release
kobject: 'queues' (00000000a107c4cd): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000005e65baa9): kobject_uevent_env
kobject: 'ip6gre0' (000000005e65baa9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000009936e97): kobject_cleanup, parent 000000008ec9e778
kobject: 'rx-0' (0000000009936e97): auto cleanup 'remove' event
kobject: 'rx-0' (0000000009936e97): kobject_uevent_env
kobject: 'rx-0' (0000000009936e97): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000009936e97): auto cleanup kobject_del
kobject: 'rx-0' (0000000009936e97): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000001d86a1e2): kobject_cleanup, parent 000000008ec9e778
kobject: 'tx-0' (000000001d86a1e2): auto cleanup 'remove' event
kobject: 'tx-0' (000000001d86a1e2): kobject_uevent_env
kobject: 'tx-0' (000000001d86a1e2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000001d86a1e2): auto cleanup kobject_del
kobject: 'tx-0' (000000001d86a1e2): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000008ec9e778): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000008ec9e778): calling ktype release
kobject: 'queues' (000000008ec9e778): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000cd1ee44d): kobject_uevent_env
kobject: 'ip6gre0' (00000000cd1ee44d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a76e9df2): kobject_cleanup, parent 0000000023fcd277
kobject: 'rx-0' (00000000a76e9df2): auto cleanup 'remove' event
kobject: 'rx-0' (00000000a76e9df2): kobject_uevent_env
kobject: 'rx-0' (00000000a76e9df2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a76e9df2): auto cleanup kobject_del
kobject: 'rx-0' (00000000a76e9df2): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000f2d38e7f): kobject_cleanup, parent 0000000023fcd277
kobject: 'tx-0' (00000000f2d38e7f): auto cleanup 'remove' event
kobject: 'tx-0' (00000000f2d38e7f): kobject_uevent_env
kobject: 'tx-0' (00000000f2d38e7f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000f2d38e7f): auto cleanup kobject_del
kobject: 'tx-0' (00000000f2d38e7f): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000023fcd277): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000023fcd277): calling ktype release
kobject: 'queues' (0000000023fcd277): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000043e42a8f): kobject_uevent_env
kobject: 'ip6gre0' (0000000043e42a8f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000406426f1): kobject_cleanup, parent 000000007746cc46
kobject: 'rx-0' (00000000406426f1): auto cleanup 'remove' event
kobject: 'rx-0' (00000000406426f1): kobject_uevent_env
kobject: 'rx-0' (00000000406426f1): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000406426f1): auto cleanup kobject_del
kobject: 'rx-0' (00000000406426f1): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000dc1a620b): kobject_cleanup, parent 000000007746cc46
kobject: 'tx-0' (00000000dc1a620b): auto cleanup 'remove' event
kobject: 'tx-0' (00000000dc1a620b): kobject_uevent_env
kobject: 'tx-0' (00000000dc1a620b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000dc1a620b): auto cleanup kobject_del
kobject: 'tx-0' (00000000dc1a620b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000007746cc46): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000007746cc46): calling ktype release
kobject: 'queues' (000000007746cc46): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000009464ec70): kobject_uevent_env
kobject: 'ip6gre0' (000000009464ec70): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000aa648a91): kobject_cleanup, parent 00000000a14404ed
kobject: 'rx-0' (00000000aa648a91): auto cleanup 'remove' event
kobject: 'rx-0' (00000000aa648a91): kobject_uevent_env
kobject: 'rx-0' (00000000aa648a91): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000aa648a91): auto cleanup kobject_del
kobject: 'rx-0' (00000000aa648a91): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000e01cdeea): kobject_cleanup, parent 00000000a14404ed
kobject: 'tx-0' (00000000e01cdeea): auto cleanup 'remove' event
kobject: 'tx-0' (00000000e01cdeea): kobject_uevent_env
kobject: 'tx-0' (00000000e01cdeea): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000e01cdeea): auto cleanup kobject_del
kobject: 'tx-0' (00000000e01cdeea): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000a14404ed): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000a14404ed): calling ktype release
kobject: 'queues' (00000000a14404ed): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000dcf9157f): kobject_uevent_env
kobject: 'ip6gre0' (00000000dcf9157f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000bcfcbeb2): kobject_cleanup, parent 00000000f9140c0a
kobject: 'rx-0' (00000000bcfcbeb2): auto cleanup 'remove' event
kobject: 'rx-0' (00000000bcfcbeb2): kobject_uevent_env
kobject: 'rx-0' (00000000bcfcbeb2): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000bcfcbeb2): auto cleanup kobject_del
kobject: 'rx-0' (00000000bcfcbeb2): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000e6a85471): kobject_cleanup, parent 00000000f9140c0a
kobject: 'tx-0' (00000000e6a85471): auto cleanup 'remove' event
kobject: 'tx-0' (00000000e6a85471): kobject_uevent_env
kobject: 'tx-0' (00000000e6a85471): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000e6a85471): auto cleanup kobject_del
kobject: 'tx-0' (00000000e6a85471): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f9140c0a): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000f9140c0a): calling ktype release
kobject: 'queues' (00000000f9140c0a): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000c73ea5ea): kobject_uevent_env
kobject: 'ip6gre0' (00000000c73ea5ea): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c94c7e61): kobject_cleanup, parent 00000000bbaf8d5c
kobject: 'rx-0' (00000000c94c7e61): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c94c7e61): kobject_uevent_env
kobject: 'rx-0' (00000000c94c7e61): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c94c7e61): auto cleanup kobject_del
kobject: 'rx-0' (00000000c94c7e61): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000e7802118): kobject_cleanup, parent 00000000bbaf8d5c
kobject: 'tx-0' (00000000e7802118): auto cleanup 'remove' event
kobject: 'tx-0' (00000000e7802118): kobject_uevent_env
kobject: 'tx-0' (00000000e7802118): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000e7802118): auto cleanup kobject_del
kobject: 'tx-0' (00000000e7802118): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000bbaf8d5c): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000bbaf8d5c): calling ktype release
kobject: 'queues' (00000000bbaf8d5c): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000bd426f43): kobject_uevent_env
kobject: 'ip6gre0' (00000000bd426f43): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000ae224d7b): kobject_cleanup, parent 00000000f53e37c2
kobject: 'rx-0' (00000000ae224d7b): auto cleanup 'remove' event
kobject: 'rx-0' (00000000ae224d7b): kobject_uevent_env
kobject: 'rx-0' (00000000ae224d7b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000ae224d7b): auto cleanup kobject_del
kobject: 'rx-0' (00000000ae224d7b): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000007ed38c32): kobject_cleanup, parent 00000000f53e37c2
kobject: 'tx-0' (000000007ed38c32): auto cleanup 'remove' event
kobject: 'tx-0' (000000007ed38c32): kobject_uevent_env
kobject: 'tx-0' (000000007ed38c32): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000007ed38c32): auto cleanup kobject_del
kobject: 'tx-0' (000000007ed38c32): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f53e37c2): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000f53e37c2): calling ktype release
kobject: 'queues' (00000000f53e37c2): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000e5b68383): kobject_uevent_env
kobject: 'ip6gre0' (00000000e5b68383): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000032b7d82d): kobject_cleanup, parent 0000000046a4b147
kobject: 'rx-0' (0000000032b7d82d): auto cleanup 'remove' event
kobject: 'rx-0' (0000000032b7d82d): kobject_uevent_env
kobject: 'rx-0' (0000000032b7d82d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000032b7d82d): auto cleanup kobject_del
kobject: 'rx-0' (0000000032b7d82d): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000ecee562b): kobject_cleanup, parent 0000000046a4b147
kobject: 'tx-0' (00000000ecee562b): auto cleanup 'remove' event
kobject: 'tx-0' (00000000ecee562b): kobject_uevent_env
kobject: 'tx-0' (00000000ecee562b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000ecee562b): auto cleanup kobject_del
kobject: 'tx-0' (00000000ecee562b): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000046a4b147): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000046a4b147): calling ktype release
kobject: 'queues' (0000000046a4b147): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000034e8fce4): kobject_uevent_env
kobject: 'ip6gre0' (0000000034e8fce4): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d64b193d): kobject_cleanup, parent 00000000d3240690
kobject: 'rx-0' (00000000d64b193d): auto cleanup 'remove' event
kobject: 'rx-0' (00000000d64b193d): kobject_uevent_env
kobject: 'rx-0' (00000000d64b193d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000d64b193d): auto cleanup kobject_del
kobject: 'rx-0' (00000000d64b193d): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000de823788): kobject_cleanup, parent 00000000d3240690
kobject: 'tx-0' (00000000de823788): auto cleanup 'remove' event
kobject: 'tx-0' (00000000de823788): kobject_uevent_env
kobject: 'tx-0' (00000000de823788): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000de823788): auto cleanup kobject_del
kobject: 'tx-0' (00000000de823788): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000d3240690): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000d3240690): calling ktype release
kobject: 'queues' (00000000d3240690): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000037469a49): kobject_uevent_env
kobject: 'ip6gre0' (0000000037469a49): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007256ed19): kobject_cleanup, parent 00000000b6cac8e1
kobject: 'rx-0' (000000007256ed19): auto cleanup 'remove' event
kobject: 'rx-0' (000000007256ed19): kobject_uevent_env
kobject: 'rx-0' (000000007256ed19): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000007256ed19): auto cleanup kobject_del
kobject: 'rx-0' (000000007256ed19): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000976f5487): kobject_cleanup, parent 00000000b6cac8e1
kobject: 'tx-0' (00000000976f5487): auto cleanup 'remove' event
kobject: 'tx-0' (00000000976f5487): kobject_uevent_env
kobject: 'tx-0' (00000000976f5487): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000976f5487): auto cleanup kobject_del
kobject: 'tx-0' (00000000976f5487): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000b6cac8e1): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000b6cac8e1): calling ktype release
kobject: 'queues' (00000000b6cac8e1): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000dd6f5b20): kobject_uevent_env
kobject: 'ip6gre0' (00000000dd6f5b20): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c310e950): kobject_cleanup, parent 0000000001335301
kobject: 'rx-0' (00000000c310e950): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c310e950): kobject_uevent_env
kobject: 'rx-0' (00000000c310e950): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c310e950): auto cleanup kobject_del
kobject: 'rx-0' (00000000c310e950): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000a22dac40): kobject_cleanup, parent 0000000001335301
kobject: 'tx-0' (00000000a22dac40): auto cleanup 'remove' event
kobject: 'tx-0' (00000000a22dac40): kobject_uevent_env
kobject: 'tx-0' (00000000a22dac40): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000a22dac40): auto cleanup kobject_del
kobject: 'tx-0' (00000000a22dac40): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000001335301): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000001335301): calling ktype release
kobject: 'queues' (0000000001335301): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000b49b9097): kobject_uevent_env
kobject: 'ip6gre0' (00000000b49b9097): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002c2dc2a0): kobject_cleanup, parent 00000000dfc006bd
kobject: 'rx-0' (000000002c2dc2a0): auto cleanup 'remove' event
kobject: 'rx-0' (000000002c2dc2a0): kobject_uevent_env
kobject: 'rx-0' (000000002c2dc2a0): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002c2dc2a0): auto cleanup kobject_del
kobject: 'rx-0' (000000002c2dc2a0): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000811d59fd): kobject_cleanup, parent 00000000dfc006bd
kobject: 'tx-0' (00000000811d59fd): auto cleanup 'remove' event
kobject: 'tx-0' (00000000811d59fd): kobject_uevent_env
kobject: 'tx-0' (00000000811d59fd): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000811d59fd): auto cleanup kobject_del
kobject: 'tx-0' (00000000811d59fd): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000dfc006bd): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000dfc006bd): calling ktype release
kobject: 'queues' (00000000dfc006bd): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000d8ca0851): kobject_uevent_env
kobject: 'ip6gre0' (00000000d8ca0851): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005798ac69): kobject_cleanup, parent 0000000092e18f41
kobject: 'rx-0' (000000005798ac69): auto cleanup 'remove' event
kobject: 'rx-0' (000000005798ac69): kobject_uevent_env
kobject: 'rx-0' (000000005798ac69): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000005798ac69): auto cleanup kobject_del
kobject: 'rx-0' (000000005798ac69): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000d77f11e5): kobject_cleanup, parent 0000000092e18f41
kobject: 'tx-0' (00000000d77f11e5): auto cleanup 'remove' event
kobject: 'tx-0' (00000000d77f11e5): kobject_uevent_env
kobject: 'tx-0' (00000000d77f11e5): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000d77f11e5): auto cleanup kobject_del
kobject: 'tx-0' (00000000d77f11e5): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000092e18f41): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000092e18f41): calling ktype release
kobject: 'queues' (0000000092e18f41): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000001173cf96): kobject_uevent_env
kobject: 'ip6gre0' (000000001173cf96): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000054f51df6): kobject_cleanup, parent 0000000085cf13b7
kobject: 'rx-0' (0000000054f51df6): auto cleanup 'remove' event
kobject: 'rx-0' (0000000054f51df6): kobject_uevent_env
kobject: 'rx-0' (0000000054f51df6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000054f51df6): auto cleanup kobject_del
kobject: 'rx-0' (0000000054f51df6): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000617e0395): kobject_cleanup, parent 0000000085cf13b7
kobject: 'tx-0' (00000000617e0395): auto cleanup 'remove' event
kobject: 'tx-0' (00000000617e0395): kobject_uevent_env
kobject: 'tx-0' (00000000617e0395): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000617e0395): auto cleanup kobject_del
kobject: 'tx-0' (00000000617e0395): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000085cf13b7): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000085cf13b7): calling ktype release
kobject: 'queues' (0000000085cf13b7): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000479b8166): kobject_uevent_env
kobject: 'ip6gre0' (00000000479b8166): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000068682a1f): kobject_cleanup, parent 0000000017973315
kobject: 'rx-0' (0000000068682a1f): auto cleanup 'remove' event
kobject: 'rx-0' (0000000068682a1f): kobject_uevent_env
kobject: 'rx-0' (0000000068682a1f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000068682a1f): auto cleanup kobject_del
kobject: 'rx-0' (0000000068682a1f): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000004ab32a00): kobject_cleanup, parent 0000000017973315
kobject: 'tx-0' (000000004ab32a00): auto cleanup 'remove' event
kobject: 'tx-0' (000000004ab32a00): kobject_uevent_env
kobject: 'tx-0' (000000004ab32a00): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000004ab32a00): auto cleanup kobject_del
kobject: 'tx-0' (000000004ab32a00): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000017973315): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000017973315): calling ktype release
kobject: 'queues' (0000000017973315): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000d4b0a8ed): kobject_uevent_env
kobject: 'ip6gre0' (00000000d4b0a8ed): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002fad872b): kobject_cleanup, parent 000000003f89e112
kobject: 'rx-0' (000000002fad872b): auto cleanup 'remove' event
kobject: 'rx-0' (000000002fad872b): kobject_uevent_env
kobject: 'rx-0' (000000002fad872b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002fad872b): auto cleanup kobject_del
kobject: 'rx-0' (000000002fad872b): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000fe420941): kobject_cleanup, parent 000000003f89e112
kobject: 'tx-0' (00000000fe420941): auto cleanup 'remove' event
kobject: 'tx-0' (00000000fe420941): kobject_uevent_env
kobject: 'tx-0' (00000000fe420941): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000fe420941): auto cleanup kobject_del
kobject: 'tx-0' (00000000fe420941): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000003f89e112): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000003f89e112): calling ktype release
kobject: 'queues' (000000003f89e112): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000020dd0ad9): kobject_uevent_env
kobject: 'ip6gre0' (0000000020dd0ad9): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000003dd3d97e): kobject_cleanup, parent 00000000f4ba214f
kobject: 'rx-0' (000000003dd3d97e): auto cleanup 'remove' event
kobject: 'rx-0' (000000003dd3d97e): kobject_uevent_env
kobject: 'rx-0' (000000003dd3d97e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000003dd3d97e): auto cleanup kobject_del
kobject: 'rx-0' (000000003dd3d97e): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000000495b423): kobject_cleanup, parent 00000000f4ba214f
kobject: 'tx-0' (000000000495b423): auto cleanup 'remove' event
kobject: 'tx-0' (000000000495b423): kobject_uevent_env
kobject: 'tx-0' (000000000495b423): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000000495b423): auto cleanup kobject_del
kobject: 'tx-0' (000000000495b423): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f4ba214f): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000f4ba214f): calling ktype release
kobject: 'queues' (00000000f4ba214f): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000002a3f422a): kobject_uevent_env
kobject: 'ip6gre0' (000000002a3f422a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000009a2510fb): kobject_cleanup, parent 0000000053b27ac3
kobject: 'rx-0' (000000009a2510fb): auto cleanup 'remove' event
kobject: 'rx-0' (000000009a2510fb): kobject_uevent_env
kobject: 'rx-0' (000000009a2510fb): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000009a2510fb): auto cleanup kobject_del
kobject: 'rx-0' (000000009a2510fb): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000076ddb05c): kobject_cleanup, parent 0000000053b27ac3
kobject: 'tx-0' (0000000076ddb05c): auto cleanup 'remove' event
kobject: 'tx-0' (0000000076ddb05c): kobject_uevent_env
kobject: 'tx-0' (0000000076ddb05c): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000076ddb05c): auto cleanup kobject_del
kobject: 'tx-0' (0000000076ddb05c): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000053b27ac3): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000053b27ac3): calling ktype release
kobject: 'queues' (0000000053b27ac3): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000033eb3622): kobject_uevent_env
kobject: 'ip6gre0' (0000000033eb3622): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000008fe75e83): kobject_cleanup, parent 00000000d00673c1
kobject: 'rx-0' (000000008fe75e83): auto cleanup 'remove' event
kobject: 'rx-0' (000000008fe75e83): kobject_uevent_env
kobject: 'rx-0' (000000008fe75e83): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000008fe75e83): auto cleanup kobject_del
kobject: 'rx-0' (000000008fe75e83): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (0000000026ddbd9e): kobject_cleanup, parent 00000000d00673c1
kobject: 'tx-0' (0000000026ddbd9e): auto cleanup 'remove' event
kobject: 'tx-0' (0000000026ddbd9e): kobject_uevent_env
kobject: 'tx-0' (0000000026ddbd9e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (0000000026ddbd9e): auto cleanup kobject_del
kobject: 'tx-0' (0000000026ddbd9e): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000d00673c1): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000d00673c1): calling ktype release
kobject: 'queues' (00000000d00673c1): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000a25f02da): kobject_uevent_env
kobject: 'ip6gre0' (00000000a25f02da): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000001fee3c3a): kobject_cleanup, parent 0000000064191e03
kobject: 'rx-0' (000000001fee3c3a): auto cleanup 'remove' event
kobject: 'rx-0' (000000001fee3c3a): kobject_uevent_env
kobject: 'rx-0' (000000001fee3c3a): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000001fee3c3a): auto cleanup kobject_del
kobject: 'rx-0' (000000001fee3c3a): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000000105a2af): kobject_cleanup, parent 0000000064191e03
kobject: 'tx-0' (000000000105a2af): auto cleanup 'remove' event
kobject: 'tx-0' (000000000105a2af): kobject_uevent_env
kobject: 'tx-0' (000000000105a2af): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000000105a2af): auto cleanup kobject_del
kobject: 'tx-0' (000000000105a2af): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000064191e03): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000064191e03): calling ktype release
kobject: 'queues' (0000000064191e03): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000bac7ac3b): kobject_uevent_env
kobject: 'ip6gre0' (00000000bac7ac3b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a445ce90): kobject_cleanup, parent 00000000f017e284
kobject: 'rx-0' (00000000a445ce90): auto cleanup 'remove' event
kobject: 'rx-0' (00000000a445ce90): kobject_uevent_env
kobject: 'rx-0' (00000000a445ce90): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000a445ce90): auto cleanup kobject_del
kobject: 'rx-0' (00000000a445ce90): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000941ca72f): kobject_cleanup, parent 00000000f017e284
kobject: 'tx-0' (00000000941ca72f): auto cleanup 'remove' event
kobject: 'tx-0' (00000000941ca72f): kobject_uevent_env
kobject: 'tx-0' (00000000941ca72f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000941ca72f): auto cleanup kobject_del
kobject: 'tx-0' (00000000941ca72f): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f017e284): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000f017e284): calling ktype release
kobject: 'queues' (00000000f017e284): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000005f6f82e0): kobject_uevent_env
kobject: 'ip6gre0' (000000005f6f82e0): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c5398820): kobject_cleanup, parent 000000001b0d3b24
kobject: 'rx-0' (00000000c5398820): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c5398820): kobject_uevent_env
kobject: 'rx-0' (00000000c5398820): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c5398820): auto cleanup kobject_del
kobject: 'rx-0' (00000000c5398820): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000004b831d4d): kobject_cleanup, parent 000000001b0d3b24
kobject: 'tx-0' (000000004b831d4d): auto cleanup 'remove' event
kobject: 'tx-0' (000000004b831d4d): kobject_uevent_env
kobject: 'tx-0' (000000004b831d4d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000004b831d4d): auto cleanup kobject_del
kobject: 'tx-0' (000000004b831d4d): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (000000001b0d3b24): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (000000001b0d3b24): calling ktype release
kobject: 'queues' (000000001b0d3b24): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (000000009c06ad0b): kobject_uevent_env
kobject: 'ip6gre0' (000000009c06ad0b): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002d41e5c3): kobject_cleanup, parent 00000000acc8c62e
kobject: 'rx-0' (000000002d41e5c3): auto cleanup 'remove' event
kobject: 'rx-0' (000000002d41e5c3): kobject_uevent_env
kobject: 'rx-0' (000000002d41e5c3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (000000002d41e5c3): auto cleanup kobject_del
kobject: 'rx-0' (000000002d41e5c3): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000800dcff0): kobject_cleanup, parent 00000000acc8c62e
kobject: 'tx-0' (00000000800dcff0): auto cleanup 'remove' event
kobject: 'tx-0' (00000000800dcff0): kobject_uevent_env
kobject: 'tx-0' (00000000800dcff0): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000800dcff0): auto cleanup kobject_del
kobject: 'tx-0' (00000000800dcff0): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000acc8c62e): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000acc8c62e): calling ktype release
kobject: 'queues' (00000000acc8c62e): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000efd045c3): kobject_uevent_env
kobject: 'ip6gre0' (00000000efd045c3): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c06223f7): kobject_cleanup, parent 00000000889d7b34
kobject: 'rx-0' (00000000c06223f7): auto cleanup 'remove' event
kobject: 'rx-0' (00000000c06223f7): kobject_uevent_env
kobject: 'rx-0' (00000000c06223f7): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (00000000c06223f7): auto cleanup kobject_del
kobject: 'rx-0' (00000000c06223f7): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000009583fb49): kobject_cleanup, parent 00000000889d7b34
kobject: 'tx-0' (000000009583fb49): auto cleanup 'remove' event
kobject: 'tx-0' (000000009583fb49): kobject_uevent_env
kobject: 'tx-0' (000000009583fb49): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000009583fb49): auto cleanup kobject_del
kobject: 'tx-0' (000000009583fb49): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000889d7b34): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000889d7b34): calling ktype release
kobject: 'queues' (00000000889d7b34): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000d262c90e): kobject_uevent_env
kobject: 'ip6gre0' (00000000d262c90e): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000093d2092f): kobject_cleanup, parent 0000000025d6c973
kobject: 'rx-0' (0000000093d2092f): auto cleanup 'remove' event
kobject: 'rx-0' (0000000093d2092f): kobject_uevent_env
kobject: 'rx-0' (0000000093d2092f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000093d2092f): auto cleanup kobject_del
kobject: 'rx-0' (0000000093d2092f): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000007124fc58): kobject_cleanup, parent 0000000025d6c973
kobject: 'tx-0' (000000007124fc58): auto cleanup 'remove' event
kobject: 'tx-0' (000000007124fc58): kobject_uevent_env
kobject: 'tx-0' (000000007124fc58): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000007124fc58): auto cleanup kobject_del
kobject: 'tx-0' (000000007124fc58): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (0000000025d6c973): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (0000000025d6c973): calling ktype release
kobject: 'queues' (0000000025d6c973): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000048e5fada): kobject_uevent_env
kobject: 'ip6gre0' (0000000048e5fada): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000083b36769): kobject_cleanup, parent 00000000642902b0
kobject: 'rx-0' (0000000083b36769): auto cleanup 'remove' event
kobject: 'rx-0' (0000000083b36769): kobject_uevent_env
kobject: 'rx-0' (0000000083b36769): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000083b36769): auto cleanup kobject_del
kobject: 'rx-0' (0000000083b36769): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000d79fe629): kobject_cleanup, parent 00000000642902b0
kobject: 'tx-0' (00000000d79fe629): auto cleanup 'remove' event
kobject: 'tx-0' (00000000d79fe629): kobject_uevent_env
kobject: 'tx-0' (00000000d79fe629): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000d79fe629): auto cleanup kobject_del
kobject: 'tx-0' (00000000d79fe629): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000642902b0): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000642902b0): calling ktype release
kobject: 'queues' (00000000642902b0): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (00000000db2ff39f): kobject_uevent_env
kobject: 'ip6gre0' (00000000db2ff39f): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000027d95c1d): kobject_cleanup, parent 00000000167ee37f
kobject: 'rx-0' (0000000027d95c1d): auto cleanup 'remove' event
kobject: 'rx-0' (0000000027d95c1d): kobject_uevent_env
kobject: 'rx-0' (0000000027d95c1d): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000027d95c1d): auto cleanup kobject_del
kobject: 'rx-0' (0000000027d95c1d): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000b2e02b16): kobject_cleanup, parent 00000000167ee37f
kobject: 'tx-0' (00000000b2e02b16): auto cleanup 'remove' event
kobject: 'tx-0' (00000000b2e02b16): kobject_uevent_env
kobject: 'tx-0' (00000000b2e02b16): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (00000000b2e02b16): auto cleanup kobject_del
kobject: 'tx-0' (00000000b2e02b16): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000167ee37f): kobject_cleanup, parent  
0000000074ba00ba
kobject: 'queues' (00000000167ee37f): calling ktype release
kobject: 'queues' (00000000167ee37f): kset_release
kobject: 'queues': free name
kobject: 'ip6gre0' (0000000088a31351): kobject_uevent_env
kobject: 'ip6gre0' (0000000088a31351): kobject_uevent_env: uevent_suppress  
cau
