Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79CFE615
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2019 20:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKOTzC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Nov 2019 14:55:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:34427 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOTzC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Nov 2019 14:55:02 -0500
Received: by mail-io1-f70.google.com with SMTP id a13so7950093iol.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Nov 2019 11:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U5n1EJvZkiPV6GmPCMijT0bUs78C96Uzo+x4t7ZUFTY=;
        b=PilwsT9eNvU2iWA/FyrMAIAYxD+Sx9ph1u4IOe5utx4choIfYjzgRngN+nJzXoSaLB
         /nwpRzpIQoaYf7eh8oPYP7CYXp/umpYoxpHsuDu4duwK9+oOpPNqb0WaxBATJKrgDC+b
         8I4LLv/jMGY4S1ysdQ01ZKemztdD4E1T9yC2flTrMZ3/JtDjSC01wHdW9fJ821nk4Dr7
         dBc2M09gZBkUMqYcmS3//AxgBel2IFxfsODpw+g8m1T6n1MJhXIwoEKatKiR3TE+hgUT
         XY8bCflrLkIlh6ikZ3jlfaJ1T/MMXWuX7e2h9By6C7irH7vlulr1ir3k9NkbC3kgt5mg
         7Z0g==
X-Gm-Message-State: APjAAAW8MNRImoLTTDh/JFPlGIVpd5J8gIxHwo8ncfa6ORESHQ2fGFrv
        /fUrSLuRLGCg2oeXen4OgQ3/LgGnPFSo5mz6XZRo/4+qlOak
X-Google-Smtp-Source: APXvYqxIGmxq4iqQA3DbtD/X1J4Jz5IYKL9pXLRzICSI/jIAIToGkzSJvfrosilkvOBlbcbr72OpVhz6cPCg1PZfxcNzZX7u8n7q
MIME-Version: 1.0
X-Received: by 2002:a02:a09:: with SMTP id 9mr2409414jaw.84.1573847701206;
 Fri, 15 Nov 2019 11:55:01 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:55:01 -0800
In-Reply-To: <000000000000ec7273058b877e1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029432d059767f930@google.com>
Subject: Re: BUG: MAX_LOCKDEP_ENTRIES too low!
From:   syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
To:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, cleech@redhat.com,
        daniel@iogearbox.net, davem@davemloft.net, dev@openvswitch.org,
        dsa@cumulusnetworks.com, edumazet@google.com, f.fainelli@gmail.com,
        fw@strlen.de, gbastien@versatic.net, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, haiyangz@microsoft.com,
        idosch@mellanox.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi,
        jack@suse.com, jack@suse.cz, jakub.kicinski@netronome.com,
        jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us,
        johan.hedberg@gmail.com, johannes.berg@intel.com,
        john.hurley@netronome.com, jwi@linux.ibm.com,
        kstewart@linuxfoundation.org, kvalo@codeaurora.org,
        kys@microsoft.com, linmiaohe@huawei.com,
        linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-wpan@vger.kernel.org, liuhangbin@gmail.com,
        marcel@holtmann.org, mareklindner@neomailbox.ch, mcroce@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1126f5c2e00000
start commit:   0e3f1ad8 Remove VirtualBox guest shared folders filesystem
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1326f5c2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1526f5c2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1aab6d4187ddf667
dashboard link: https://syzkaller.appspot.com/bug?extid=cd0ec5211ac07c18c049
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171546ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133ed206e00000

Reported-by: syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
