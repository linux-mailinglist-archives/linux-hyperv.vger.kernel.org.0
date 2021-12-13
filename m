Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492CC472130
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Dec 2021 07:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhLMGpM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Dec 2021 01:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLMGpM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Dec 2021 01:45:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5DCC06173F
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 22:45:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u3so28988060lfl.2
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 22:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fa+9+pEcmDSlqNnXZsxyljwGz3+L2OAQD+rraOW0LuE=;
        b=iB/ZZtRKE3jMoHG0LOAawYJYRRUvRDxaOABkpO4dDq2JFJlgyYsSynsY6gkSHUUhY1
         +PqxiI4giKBCMIkWsSryCw8Rn5lOhx7VBE8YODQM4mF89E0BHAJ0kg26WMdmT50R0jvG
         KwCIr7PWnIbgSJKZqcg4eG73t7PVX+w1f/kopkeb7RvZg+ffzc+h81h8GoHw3nNyOLG/
         bGMEAnoGc+Jx1PgTOUqtDoqo852u3b3WjWIt4fRflGsPSTyV7JcldH0rJr2Agagmwm+w
         HI7VXnZXlo8tqN5pO6ldnIsq15dXbTviCmzGFGgFSQ8iRI0B+GRduAjTFvJt4WsHeiGY
         v9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fa+9+pEcmDSlqNnXZsxyljwGz3+L2OAQD+rraOW0LuE=;
        b=Lg37Urt34vuvq2TyHOWJNDluwpWY7hYVhMYaAbVKnw4jTA6uNsvmVxoGQe5VsM3ipi
         9QYU1UL8ApdCIo846ClW5Vz620qH3qYPovCP0W5usmc3dYb0rmDE9RyIAO5AI8IOPVWz
         XBMKTHyzYWdc+Ol2fLtSeSb5EQQPW8YRzMWA9U6dtSadsGyd3gwfY2nHbuEJt3NpOYfL
         xgg3w4RrwnsjclmWdc/yuNv66rAkfdRc2lXROfJD+LnrnPgUqyy2GwjzO79U17Ws/3Kp
         tADjiaZwYFpACgbOg5wwRDNpT0wVRG1RIQMK2w6stQbLirjSqoTFbzYvD1CD+bSI3Qqg
         4CuQ==
X-Gm-Message-State: AOAM5335p7OwBfaTTvn4KHY9si3opWAy6d83mHfCB/BY77Zc+ft7lOLA
        +EfL5qkMn3oRm/NEsug/NNELKP27k6OzpzRL6M8m9zVbiM2J0w==
X-Google-Smtp-Source: ABdhPJyNKGYt8yMpy9+kHE+EFJpkyIcs1mK5Acuz9JFb9q/1Wwmku75OwlRA7KH00WNLQ6v5p0fJkVN0n2zINCNu/bE=
X-Received: by 2002:a05:6512:13aa:: with SMTP id p42mr26296396lfa.474.1639377909918;
 Sun, 12 Dec 2021 22:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20211212121326.215377-1-yanminglr@gmail.com> <20211213014709.GA2316@anparri>
In-Reply-To: <20211213014709.GA2316@anparri>
From:   Yanming Liu <yanminglr@gmail.com>
Date:   Mon, 13 Dec 2021 14:44:49 +0800
Message-ID: <CAH+BkoFSxm28eQn4-OQ-Vr8MbdEQ4VZzqadbOEfFj9a5EDkFLg@mail.gmail.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 13, 2021 at 9:47 AM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Yanming,
>
> [...]
>
> > Specifically, in hv_balloon I have observed of a dm_unballoon_request
> > message of 4096 bytes being truncated to 4080 bytes. When the driver
> > tries to read next packet it starts from the wrong read_index, receives
> > garbage and prints a lot of "Unhandled message: type: <garbage>" in
> > dmesg.
>
> To make sure I understand your observations: Can you please print/share the
> values of (desc->len8 << 3) and (desc->offset8 << 3) for such a "truncated"
> packet, say, right after the
>
>         desc = hv_pkt_iter_first(channel);
>
> in hv_ringbuffer_read()?  Also, it'd be interesting to know whether any of

Sure, unfortunately I have not printed desc->len8 before and reproducing the
bug takes some time (the only reliable way I know of seems to be booting a bad
kernel, using it normally for a few hours, then running my daily backup
script), I'll reply when I have these values ready.

Meanwhile, I'd like to share how I observed a dm_unballoon_request message
being truncated. I attached the following systemtap script to a bad kernel:

    probe module("hv_balloon").statement("*@drivers/hv/hv_balloon.c:1493")
    {
        printf("balloon_onchannelcallback: recvlen = %d, dm_hdr->type = %d\n",
                 $recvlen, $dm_hdr->type);
        printf("%*.*M\n", $recvlen * 2, $recvlen, $recv_buffer);
    }

This is the trace printed when the bug happens:

balloon_onchannelcallback: recvlen = 16, dm_hdr->type = 6
06001000000000006625000000000000
balloon_onchannelcallback: recvlen = 24, dm_hdr->type = 8
080018000000000000000000010000000012000000005600
balloon_onchannelcallback: recvlen = 32, dm_hdr->type = 8
080020000000000000000000020000000068000000009000001c010000008c01
balloon_onchannelcallback: recvlen = 40, dm_hdr->type = 8
0800280000000000000000000300000000a802000000c40000700300000002000074030000001800
balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 8
080000100000000001000000fe0100002885100000d9020003881000000900000d8810000007000016881000000200001a881000000300001f88100000010000238810000001000028881000000200002d881000000300003388100000020000378810000001000039881000000100003c8810000001000062881000000[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 16138
0a3f1000000300000e3f1000000a0000503f1000000e0000603f100000230000843f100000030000883f100000100000b83f100000100000d03f100000220000f33f1000001900000d401000000100000f4010000001000012401000000400001c401000000100001e40100000010000234010000001000025401000000[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 8792
5822100000070000602210000001000063221000001200007622100000090000802210000004000085221000000300008b221000000800009a22100000160000f02210000008000010231000000100001223100000020000182310000004000029231000000e000038231000000100003a231000000100003c231000000[...]
balloon_onchannelcallback: recvlen = 1544, dm_hdr->type = 2728
a80a100000020000fa0b100000010000130c100000010000150c1000000200001b0c100000040000200c100000010000240c100000010000260c100000010000290c1000000100002e0c100000010000310c100000010000330c100000010000350c100000020000380c1000000d0000490c100000060000560c1000000[...]
balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 41981
fda3100000010000ffa31000000100000ea41000000d00001ca410000001000020a410000001000024a410000001000027a41000000100002aa410000007000032a41000000e000043a41000000100004aa410000001000054a410000002000057a410000003000060a4100000200000c0a4100000010000c4a41000002[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 20914
b2511000000a0000be51100000080000cc51100000020000d151100000090000dc51100000020000e0511000001000000052100000040000125210000003000016521000000200002052100000020000245210000001000026521000000400002c5210000006000038521000000200003e521000001200007e521000003[...]
balloon_onchannelcallback: recvlen = 1920, dm_hdr->type = 11279
0f2c100000130000232c100000010000252c100000280000502c100000140000712c100000010000742c100000020000782c1000000800008c2c100000080000962c1000000400009e2c100000020000a42c100000040000a92c100000030000ad2c1000000c0000ba2c1000000b0000c62c100000030000ca2c1000000[...]
balloon_onchannelcallback: recvlen = 1880, dm_hdr->type = 15848
e83d100000050000ee3d100000010000f03d100000090000fa3d1000001400000f3e100000050000153e100000020000183e1000000400001d3e1000000100001f3e100000070000273e100000080000313e100000010000333e100000050000393e100000080000423e1000000700004a3e1000000f00005a3e1000000[...]
balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 41981
fda3100000010000ffa31000000100000ea41000000d00001ca410000001000020a410000001000024a410000001000027a41000000100002aa410000007000032a41000000e000043a41000000100004aa410000001000054a410000002000057a410000003000060a4100000200000c0a4100000010000c4a41000002[...]
balloon_onchannelcallback: recvlen = 3968, dm_hdr->type = 20914
b2511000000a0000be51100000080000cc51100000020000d151100000090000dc51100000020000e0511000001000000052100000040000125210000003000016521000000200002052100000020000245210000001000026521000000400002c5210000006000038521000000200003e521000001200007e521000003[...]
balloon_onchannelcallback: recvlen = 1920, dm_hdr->type = 11279
0f2c100000130000232c100000010000252c100000280000502c100000140000712c100000010000742c100000020000782c1000000800008c2c100000080000962c1000000400009e2c100000020000a42c100000040000a92c100000030000ad2c1000000c0000ba2c1000000b0000c62c100000030000ca2c1000000[...]
balloon_onchannelcallback: recvlen = 1880, dm_hdr->type = 15848
e83d100000050000ee3d100000010000f03d100000090000fa3d1000001400000f3e100000050000153e100000020000183e1000000400001d3e1000000100001f3e100000070000273e100000080000313e100000010000333e100000050000393e100000080000423e1000000700004a3e1000000f00005a3e1000000[...]

struct dm_header conveniently has a u16 size field described as "Size of the
message in bytes; including the header." in hv_balloon.c, please note how the
first 4080 bytes message has size=0x1000, mismatching with recvlen.  On a good
kernel I'm seeing multiple recvlen=4096, type=8 messages under similar memory
pressure. I then ran a (painful) bisect which pointed to adae1e931acd
("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer").

> the two validations on pkt_len and pkt_offset in hv_pkt_iter_first() fails
> (so that pkt_len/pkt_offset get updated in there).

My hypothesis is that in hv_pkt_iter_first, 'bytes_avail' was set to
'rbi->pkt_buffer_size', which was used to update pkt_len later.
Please suggest better fixes as I'm not familiar with drivers/hv, thanks!

>
> Thanks,
>   Andrea
