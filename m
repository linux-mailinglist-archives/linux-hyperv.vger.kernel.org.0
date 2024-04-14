Return-Path: <linux-hyperv+bounces-1963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F28A4461
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Apr 2024 19:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D4CB20CCA
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Apr 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092071353F4;
	Sun, 14 Apr 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MquWNYP+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1440134730
	for <linux-hyperv@vger.kernel.org>; Sun, 14 Apr 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114898; cv=none; b=E8lZDeq8MfwHAurTbm9A7JZCeTFGGWi3pTGBag0kCgfyytk1Wcffiusc+dOoZiMRZ1vN5ZEPaukmQurPFgZ21mFo8IpXNbZ7RCC5Tnvbzmrs1n/7of8JHyfoo+7yBITcv3ADpk+jvz1Sv8zC/RNCeAjensohWGlT1QnzSrVGUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114898; c=relaxed/simple;
	bh=s0xZjPnsFVzQ/xziSdtwHcUmokflyzJmDWqDF/A6E88=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oi0Xy7HUK6MvhCjBbaBBVRvSIFolM2ejM9QM0lh9BfPcj0vaaa8gKTWfKcwk5ycphphL4fAZC2z/9NYZPv94iGHg9xOc1X8XncbojHmpmA81kKwE1rjW1xUJDCGMr2CbM4vZj/7tk24HsWw4zO/K71n/n7PKb5WD9yG6iz4TqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MquWNYP+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so2832045e87.2
        for <linux-hyperv@vger.kernel.org>; Sun, 14 Apr 2024 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713114894; x=1713719694; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQXcJhWhGp8E/YuzL/wC3BQ0ftVDAZHne6hubF9x8M0=;
        b=MquWNYP+reeTDlGGYKA4W3wv0TCF6uLleZtNEgT/3HIuTrYbzDDZscyjxUkBCHLFVt
         p21B5BDuFJbh9qL/pFfzWzzdqZIWmRRBbSMZJmEwsflqAMoqBpYft/1BwTSsUiR5ezDw
         GkZdX0kB0V0LaHx7R7jp7UxQkC49sQosoQghHwqCi/1CW8trpcwAZYjj7LnJMHRAsGN3
         eIcR8o5F/KSqpF7z4D3lGgQq43jPXEGoakAnA3/n0YBtgNOCx3DU9/tOQv2b9ujqcZdv
         fxaND1W2e0CsMxLVjpaL1tEBBS4iYlnfb2yJZ7C/JTf6y6Qx7z+ssMtZVHwJIwwrJqrs
         mr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713114894; x=1713719694;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQXcJhWhGp8E/YuzL/wC3BQ0ftVDAZHne6hubF9x8M0=;
        b=uYf3g6AQvG2ydtVFjG09WZn6Sse3vBdd8EUlp4XbS3RdY6rFg9qYLeR6Gmo7Cmgysn
         n/b08choOV0JLBcbYzA4omdY3kB5jvbFK/TFcceLqGvJJz22O1lDlex7GuU96LKL4LfB
         w7aV/k1RZtqDaxmXvu0JqTACMEKJ25R36+bjOY78YMvrbW6/CngAvJwO9y/KcHx5bXDi
         GsXZhnIf57ION5CT1IlKoewOKDr00jPzOlmmU9lg8QhkOfIkaF+VAYc7r8Qw0e1b2Ilo
         onfryVYdWOyzkGm/IDRS8qXhBbub1Xx0xsPxS8QAUJi28wBDwV52VBfTfygn3/6iA1vg
         tl4A==
X-Gm-Message-State: AOJu0Yzet2Sqr4WlJL+Osvm6+Sp1OVIaTanvH5kr/L3XvC+25tXfPmEU
	8s2qSZ8Uk+JgS7fwkGgzuFkLFD1lXDqHLyRzJJJmq1WwMKb7jaDyfsddEumsiwDr6ZjL78ezyDh
	AU7jBeeEBEPlop7z7VAbz2R1e4JtrEZrRz7fQmg==
X-Google-Smtp-Source: AGHT+IHtEm9j34GnM9u2PY5dC0k+1E3pDQpl+g2g0dcgr/frKrrPd5tLNDTG7K78NpP62kY6vHIlNTsU9R+9Y2ePlU8=
X-Received: by 2002:a05:6512:55b:b0:516:c860:3c70 with SMTP id
 h27-20020a056512055b00b00516c8603c70mr4727281lfl.57.1713114894016; Sun, 14
 Apr 2024 10:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francois <rigault.francois@gmail.com>
Date: Sun, 14 Apr 2024 19:14:42 +0200
Message-ID: <CAMc2VtSNEb1yogTs1fy15xW94_UwqOUVoxaLS2eJ6mcpiaXOXA@mail.gmail.com>
Subject: Nic flaps for 1 minute when reconnecting
To: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello (I'm not subscribed to this list)
I run a few Linux machines on Hyper-V on my Windows 10 laptop
and notice that, from time to time, they lose the network for about 1 minut=
e
(briefly coming back up then down again)
I don't know what the actual trigger is, but I believe the "flapping"
is caused by the delay linked to "LINKCHANGE_INT".

Following is how I reproduce, the logs on Linux side, Windows side,
and patch I am running to avoid this.

I manage to reproduce this way: in Windows, run the "Services" app,
right click the "Internet Connecting Sharing (ICS)" service, choose restart=
...

on my VM I read these logs:

----
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream NetworkManager[1013]: <trace>
[1703407173.1367] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101 <UP;broadcast,multicast,up> mtu
1500 arp 1 ethernet? not-init addrgenmode none>d=C3=A9c. 24 09:39:33 stream
NetworkManager[1013]: <debug> [1703407173.1368] platform:
(enx00155d343101) signal: link changed: 2: enx00155d343101
<UP;broadcast,multicast,up> mtu 1500 arp 1 ethernet? init addrgenmode
none addr 00:15:5D:34:3>d=C3=A9c. 24 09:39:33 stream NetworkManager[1013]:
<trace> [1703407173.1368] l3cfg[17837add519934e3,ifindex=3D2]: emit
signal (platform-change, obj-type=3Dlink, change=3Dchanged, obj=3D2:
enx00155d343101 <UP;broadcast,multicast,up> mtu 1500 arp 1 >d=C3=A9c. 24
09:39:33 stream kernel: hv_netvsc 9538b269-5961-4c95-aa0b-b2994c468668
enx00155d343101: RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf
len 0, buf offset 0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream NetworkManager[1013]: <debug>
[1703407173.1368] device[cf06ffc422da9956] (enx00155d343101): queued
link change for ifindex 2
d=C3=A9c. 24 09:39:33 stream NetworkManager[1013]: <debug>
[1703407173.1371] device[cf06ffc422da9956] (enx00155d343101): carrier:
link disconnected (deferring action for 6000 milliseconds)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000c, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 20, status 0x4001000b, buf len 0, buf offset
0)
d=C3=A9c. 24 09:39:33 stream kernel: hv_netvsc
9538b269-5961-4c95-aa0b-b2994c468668 enx00155d343101:
RNDIS_MSG_INDICATE (len 176, status 0x40020006, buf len 156, buf
offset 12)
d=C3=A9c. 24 09:39:37 stream NetworkManager[1013]: <trace>
[1703407177.2456] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
ethernet? >d=C3=A9c. 24 09:39:37 stream NetworkManager[1013]: <debug>
[1703407177.2457] platform: (enx00155d343101) signal: link changed: 2:
enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
mtu 1500 arp 1 ethernet? init addrgenmod>d=C3=A9c. 24 09:39:37 stream
NetworkManager[1013]: <trace> [1703407177.2457]
l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running>d=C3=A9c. 24 09:39:37 stream
NetworkManager[1013]: <debug> [1703407177.2458]
device[cf06ffc422da9956] (enx00155d343101): queued link change for
ifindex 2
d=C3=A9c. 24 09:39:37 stream NetworkManager[1013]: <info>
[1703407177.2460] device (enx00155d343101): carrier: link connected
d=C3=A9c. 24 09:39:37 stream NetworkManager[1013]: <debug>
[1703407177.2461] device[cf06ffc422da9956] (enx00155d343101): carrier:
link disconnected (canceling deferred action)
d=C3=A9c. 24 09:39:37 stream NetworkManager[1013]: <trace>
[1703407177.2462] ethtool[2]: ETHTOOL_GSET, enx00155d343101: success
d=C3=A9c. 24 09:39:39 stream NetworkManager[1013]: <trace>
[1703407179.2935] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
ethernet? >d=C3=A9c. 24 09:39:39 stream NetworkManager[1013]: <debug>
[1703407179.2936] platform: (enx00155d343101) signal: link changed: 2:
enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
mtu 1500 arp 1 ethernet? init addrgenmod>d=C3=A9c. 24 09:39:39 stream
NetworkManager[1013]: <trace> [1703407179.2936]
l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running>d=C3=A9c. 24 09:39:39 stream
NetworkManager[1013]: <debug> [1703407179.2936]
device[cf06ffc422da9956] (enx00155d343101): queued link change for
ifindex 2
d=C3=A9c. 24 09:39:39 stream NetworkManager[1013]: <trace>
[1703407179.2936] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
ethernet? >d=C3=A9c. 24 09:39:41 stream NetworkManager[1013]: <trace>
[1703407181.3417] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101 <UP;broadcast,multicast,up> mtu
1500 arp 1 ethernet? not-init addrgenmode none>d=C3=A9c. 24 09:39:41 stream
NetworkManager[1013]: <debug> [1703407181.3418] platform:
(enx00155d343101) signal: link changed: 2: enx00155d343101
<UP;broadcast,multicast,up> mtu 1500 arp 1 ethernet? init addrgenmode
none addr 00:15:5D:34:3>d=C3=A9c. 24 09:39:41 stream NetworkManager[1013]:
<trace> [1703407181.3418] l3cfg[17837add519934e3,ifindex=3D2]: emit
signal (platform-change, obj-type=3Dlink, change=3Dchanged, obj=3D2:
enx00155d343101 <UP;broadcast,multicast,up> mtu 1500 arp 1 >d=C3=A9c. 24
09:39:41 stream NetworkManager[1013]: <debug> [1703407181.3418]
device[cf06ffc422da9956] (enx00155d343101): queued link change for
ifindex 2
d=C3=A9c. 24 09:39:41 stream NetworkManager[1013]: <debug>
[1703407181.3424] device[cf06ffc422da9956] (enx00155d343101): carrier:
link disconnected (deferring action for 6000 milliseconds)
d=C3=A9c. 24 09:39:45 stream NetworkManager[1013]: <trace>
[1703407185.4376] platform-linux: event-notification: RTM_NEWLINK,
flags 0, seq 0: 2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500 arp 1
ethernet? >d=C3=A9c. 24 09:39:45 stream NetworkManager[1013]: <debug>
[1703407185.4377] platform: (enx00155d343101) signal: link changed: 2:
enx00155d343101 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
mtu 1500 arp 1 ethernet? init addrgenmod>d=C3=A9c. 24 09:39:45 stream
NetworkManager[1013]: <trace> [1703407185.4377]
l3cfg[17837add519934e3,ifindex=3D2]: emit signal (platform-change,
obj-type=3Dlink, change=3Dchanged, obj=3D2: enx00155d343101
<UP,LOWER_UP;broadcast,multicast,up,running>d=C3=A9c. 24 09:39:45 stream
NetworkManager[1013]: <debug> [1703407185.4377]
device[cf06ffc422da9956] (enx00155d343101): queued link change for
ifindex 2
d=C3=A9c. 24 09:39:45 stream NetworkManager[1013]: <info>
[1703407185.4380] device (enx00155d343101): carrier: link connected
d=C3=A9c. 24 09:39:45 stream NetworkManager[1013]: <debug>
[1703407185.4381] device[cf06ffc422da9956] (enx00155d343101): carrier:
link disconnected (canceling deferred action)
d=C3=A9c. 24 09:39:45 stream NetworkManager[1013]: <trace>
[1703407185.4382] ethtool[2]: ETHTOOL_GSET, enx00155d343101: success
...
d=C3=A9c. 24 09:39:53 stream NetworkManager[1013]: <info>
[1703407193.6298] device (enx00155d343101): carrier: link connected
...
d=C3=A9c. 24 09:40:01 stream NetworkManager[1013]: <info>
[1703407201.8219] device (enx00155d343101): carrier: link connected
...
d=C3=A9c. 24 09:40:10 stream NetworkManager[1013]: <info>
[1703407210.0138] device (enx00155d343101): carrier: link connected
...
d=C3=A9c. 24 09:40:18 stream NetworkManager[1013]: <info>
[1703407218.2059] device (enx00155d343101): carrier: link connected
----

while Windows events show:

----
Get-WinEvent -LogName  Microsoft-Windows-Hyper-V-VmSwitch-Operational
-MaxEvents 50 -FilterXPath "*[System[Level<5]]"

   ProviderName: Microsoft-Windows-Hyper-V-VmSwitch

TimeCreated                      Id LevelDisplayName Message
-----------                      -- ---------------- -------
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Connected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(Nic Disconnected) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
24/12/2023 09:39:33             220 Information      Status change
(IPSEC Disable) sent to Nic
40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
----

It seems there is a quick succession of disconnections and  reconnections.
On the kernel side there seems to be a delay of 2s imposed for each of
these, so I applied this patch, as a proof of concept, to workaround
the issue:

----
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -39,7 +39,7 @@

 #define RING_SIZE_MIN  64

-#define LINKCHANGE_INT (2 * HZ)
+#define LINKCHANGE_INT (2 * HZ / 100)
 #define VF_TAKEOVER_INT (HZ / 10)

 static unsigned int ring_size __ro_after_init =3D 128;
----

which works great. Do you know if there is a real need for a 2s delay
for link change?
I experienced this issue on all the Linux VMs I booted on my laptop,
although I'm primarily running Centos Stream9.
(I reported the issue there without much luck
https://issues.redhat.com/browse/RHEL-20224, ticket is private)

Thanks!
Francois

