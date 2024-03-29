Return-Path: <linux-hyperv+bounces-1889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556778933A4
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216CFB20B1B
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D614D289;
	Sun, 31 Mar 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fYd9G8pK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610E14BFBD;
	Sun, 31 Mar 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903105; cv=fail; b=eSeRt4sHw6Ya5053q0oL2DR6KwWmnpK+Ps0/H97oHAsScFgzdT9CDJ8nNhwdg2GmwMEdL/QF6+rIQMLtQZrIydF2J9rK02LKRXoSTdQblJetMq7oZaSjh/wGi88T5KsuMtAhzSXjB8VaunLMNec5FithSRGPpI0voK2xYYMLxrQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903105; c=relaxed/simple;
	bh=JgQ07UiGphkSN0iCfnPT0dX+V0wCf7BeEqReJMB0AOA=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k2RQ967Vj9VuXdE9ZEofrBE7GKQlzQbhefNWUg81G8p3+2HY8pXSvuDna6ThVTbwFZRi0kZTby6zOnSswV4IVFn/D24iehxOk9MavZyn3k/NCGAQMdQv+pddUB1jj+hSdGtvQnc8doUSyrJxatgCm0ejKC9MRGn5l8a1dZNchuI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com; spf=fail smtp.mailfrom=microsoft.com; dkim=fail (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fYd9G8pK reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.30; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microsoft.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F1ED92082B;
	Sun, 31 Mar 2024 18:38:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPJu_l0Lebuk; Sun, 31 Mar 2024 18:38:19 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 71FC6207BB;
	Sun, 31 Mar 2024 18:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 71FC6207BB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6426480004A;
	Sun, 31 Mar 2024 18:38:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:38:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83466-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAfEemlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAI0AAADMigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 20099
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83466-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com CB976200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fYd9G8pK"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748262; cv=fail; b=iZ9ijgBMrEzSwGtKXfCOIIz5l76jgxQxCztwzrsr2v2tWGePAS8B8YbYCP3O23qo8FYz/wSJE3g7clJOMaUxLNYVpCgfRw3Ao25ru5dRg8i4Yy3B8FeH4TvtxLNPRXNsgutNfae3/nHsP9bly8h7xlhbV2C/ix/HRJLkrVVeIS4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748262; c=relaxed/simple;
	bh=S6L0aMDSpr9JXtrGomNM3mxeaZv0TjafWVbFhd/0rqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gyMEQbOJCv84m0pdHazmbwakaOv8XxjfD2pmSbQoPswacqg9FURsA6qwZWu0Hf+sqEsyw9Y3OaABpf4DKmofitkdFyagF/fpLKUormXXIbj3daiLdi8HdnRZITCLo1H7Q01Qs0yzYIJqbaUpMwmqsLhj0MOOVHTkMR5biqhYU+k=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fYd9G8pK; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+up8M1R6nWQO0DXaYd+wBDKKGB1/bicu40p0/YdAkv5mb6OJWhdTlP17CsBYvU1cTe2Vu1zbbW6YoTYwwd5z7S6kl6IQHUEC0jVb43ZLNW3tj7LDj2raILYWoEZYKLAH9zyXdXnOl7SOSi3sysssQobfkShSKfrG7Ryok6ZfoZRaqFJdOUtSMhassJPjrGCVm+vRhZP1yAdu4Hvy7HqUlMb1DRItidTQpQVxDQySKDKS38WWy7J186NC3WxvAIPzpVARGxDwaEZsEYY22ygnefkgr9AYW2iQBv1uoDT7TkXzNnCi8BQr5901BOXsVzNRVC6Lvxdp964ME/YMDJgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=;
 b=aUj3LJd3Ycvr0X8wVDCBA+o8mkkhLHtN9ZiOsnIh5olXttKBTwCbXIRoC0lcxj1hw0EqW+pqkqEN+8c1JJzbZZOEE0/7AAhxsiOgWLO+UHcuX9Js1Vlfqv3C6A8O/8l0hWiUg1iDBDAzao1x2NJAJKy/8u8Jsf2Df1QEtBzIafwlUZdCJyLIUO1dpqnbrtFXnwmCyLPFFjbr5OKs3ElFhkEqsMpxkrzN7LpbuZ+by9Wdx5f8yztSBYsoPwiZo0DODN70WlrBNZpJXqkcFghQWiSDWgY0urDSSaq17d/MtOnED8MC8FEVqXr3SQEDi/13645W+q7K/XJ4hxyxUQKEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=;
 b=fYd9G8pK/2EHHOyku2boMZZTEYjJil93H8Okh3VJ+6wmjgw0AN9tZ4ZdDJdGMumeTHFSqQ0bEwApO+U4Sh1kSdhCXJFwpcrEL090BWAyTVunPzM9/Y9HoAXH0hDO86WeTR0EFfigssLcFOoaZUZSVPNtGOVcFLEhnLmCB5bLOAQ=
From: Haiyang Zhang <haiyangz@microsoft.com>
To: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <haiyangz@microsoft.com>, <decui@microsoft.com>,
	<stephen@networkplumber.org>, <kys@microsoft.com>, <paulros@microsoft.com>,
	<olaf@aepfle.de>, <vkuznets@redhat.com>, <davem@davemloft.net>,
	<wei.liu@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <leon@kernel.org>, <longli@microsoft.com>,
	<ssengar@linux.microsoft.com>, <linux-rdma@vger.kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <sharmaajay@microsoft.com>, <hawk@kernel.org>,
	<tglx@linutronix.de>, <shradhagupta@linux.microsoft.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Date: Fri, 29 Mar 2024 14:36:53 -0700
Message-Id: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3483:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ku/LBwCcqrbaEx6WajYxO2bJE1wRc1/UmkkB1NQjnCLJv/iKgt9h7GpsW+ghqYk02boFss1T8LHLMKhIRzRY/33/YzLMxLUJw3lOXSlJ9U986LDKYqhjGpDgeg2rTNL6GGV7W59dbgTAyGUmtoOhyWIJR87QK5s2Zy5yCCMnFMNPINGcyybxpNMIGU6rtfhrWUD2VhNKIZWC5uM4Hlq0U5hc2daefmZaN4u9+a0xsfB3W4PPXcKimkfQwNelA3wmi33J+yi74mq/oMcjp79R6GECaUFmxYh0W9k/rV5eNaU71QLByO2nwZROkj6u3AOd9c4q5nUJLI1GTHWbCMY6d5lVHFaU9sF5rcOwP3JLUcWuNckouUW/3ibxfUBslG9+w2aANVnFa9PvG3J8kmqEtKqOf6GAEXH6jCT7F88w0KSHA747RtIsP8KSFWLFC2r/6n0vdOGP7UdGiNUpby/OCQAyDD2yCe77C0fnFLhpEJ+yLaCXv3P7/whpDFta9pzX4QrthuFKRTo5zP3CB4IwUhUess9Wk+EUkcMq/Hww/27g++JIPQkyIhCsthN5ikSoMn9XFqXhhW0M57njmQn3ZMN/Bt4UKvs98l968yZoWZ2XXgeOSypq9OfrwVR9o7QZf+/pOA18a9pBJksxOdHI+lK6gJXL2o55PIGmH18Sgo//MXWhHoAN/8yp+PcRFkfOELKdetoyC2P2RkcgIGFUKIDljA8iVtUEx4HikFzEAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRifRCih3C8HkWBa8isOeD8NZLiEjS6Sx0Ha6ACgXSDSbbudtEc4pY7tMBWP?=
 =?us-ascii?Q?AXPuUNiTlJzCDh3KZ0krvkrrmbVW6ubMf7utbQ5GdifXuPwzaj4hHTATytyY?=
 =?us-ascii?Q?wfUElHzsJgdqBlkYD2l5Z9nBQyUKVtcC9/91I9RtMEOnX/Qf7c8lb+tHd+5i?=
 =?us-ascii?Q?sdtDOAQcHI3nZqEo0/ZBCeSI+eKe4bxYqskPqpNt2EOjmoonoq+pw8Y8i5+A?=
 =?us-ascii?Q?z7gyHg+Up6p+nbetWV8Ztyq2J30/blP7zyzrxcFS624iyKQ5jN5GlKV1sJxQ?=
 =?us-ascii?Q?Yv135/UYBX7n87+EGGW/9hS7O+vOpJV2jkbWk0CPAtNi0g/o7J15TePfYppp?=
 =?us-ascii?Q?VghHsNq6ouqc8Z+Wjsyhph4Rxe5H/PDNZzRKOe+i87Wk9T9XL4UGgLz6KJvf?=
 =?us-ascii?Q?yDP5Jts6TF0jnJl0O8Y7c28SCIxJNBtpthTXQnxuruVBwtbpIWQTJjTONR07?=
 =?us-ascii?Q?Q05b/bVl4TrHIsdURrX56B+vn/t6UU+Mvc3wnH3ywN+uPzRqNu1VHlSGft2C?=
 =?us-ascii?Q?7jjoL+twQfrW6QwFSVSBJJZDqjXQHTssVD+SAJsDgkociG/hrhAz5q1V721m?=
 =?us-ascii?Q?5tIaGkClBT62EOcXnNUSrb1UpDgaA8aVbn9VxivjhiHfMO6pylv2aIK+4yMZ?=
 =?us-ascii?Q?+7LCrKz7IzdC/LtUl/s4HJ73wg0TjFXI/8LdMGaMMSDqPESbMCeHTJqTr7bM?=
 =?us-ascii?Q?0iAkVYn1BwdQvdUi1F4fCRIvDSDf/usQR8L1jGm4L8h/zW2rxmn1WtRWZZTN?=
 =?us-ascii?Q?NL6gZEYDamc+Ogd6G+PpEgBGFJ1NOJhIhNUD0L0/WLTO1iMZxoOV8aJodCgr?=
 =?us-ascii?Q?14jFdr2sIl4tetbQxXN/lnEEYKEz+neUSlyVGlOuvVZ+eE/6oPRNbj0aTCr3?=
 =?us-ascii?Q?hRkJWh/eBah/Ye3UpPgRlHgJ0+2CK/8Hcb0j3W2qMneCDNyc1Duzx30r714r?=
 =?us-ascii?Q?hVnwMM92AvBh4zqJRTd0/Sdpyud9536MHJ7NV6+5Qy6MCS7akyLFfIoW3Tth?=
 =?us-ascii?Q?qeBusz54Oh0Yv2jo2BzHfE+w//n5Ck65WwYFqY75UBO90R+UTsSatlE6Yp+z?=
 =?us-ascii?Q?VLQyccetYjE29NvHb5lODYNJ+MZVKy865+aO4VNkL/y/YMUHtSRT5wBztIZb?=
 =?us-ascii?Q?AAkd3ZIQCDQ70+53B+/GcIjZE/rLn3gJKzfHNZusXsjcSZ6BXrBMMXzV5/Xf?=
 =?us-ascii?Q?6iu/ra1IeHLp98NybXOr8osG9W35BVz1zKYVfCVuzP7+L6fi8ezyWZYXJLee?=
 =?us-ascii?Q?gfU602kWOMB3mqlAcsdpN49m/+CYiGXS79DLXkgs89ZlcxGiFN1u1p/c/QkP?=
 =?us-ascii?Q?1CAoQCb1U/Bb9DIJqmn+xjXyhbONwRwbQ/fx3fAFuzQUve1dt2g5+fs2yVP8?=
 =?us-ascii?Q?7egUEO9oLwNY3qQH+zRxTBse2w4maiFr45+/tc5DuL1tu09A0iwksVFzu7ON?=
 =?us-ascii?Q?4VItwdDsp5ScS7EQbwD8G22yOFUS8h3amjS7SWkm4Iax1LGaexrf1EjrKV90?=
 =?us-ascii?Q?ANSX8G2E3wB+LK8/jNpJbFJ+/pcYobj8762g99YqkbdQsGE5LwebyrV7Zt0E?=
 =?us-ascii?Q?90rCt/vq117uE//06IlTzmUNPqJIqchODzyFb7oG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d1d7b-73b5-462e-bfb8-08dc50387312
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 21:37:36.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nUR1qXP88MO1DAlmIlbknB4ftO0UuN97J7nsOcGE5t/lRakagsLUVErp3YlCGNIkfx0TlaJKjBWQsFwXnKwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3483
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
can be received and cause skb_over_panic.

Sample dmesg:
[ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536 put:1=
536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700 end:0x6ea dev:<N=
ULL>
[ 5325.243689] ------------[ cut here ]------------
[ 5325.245748] kernel BUG at net/core/skbuff.c:192!
[ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
[ 5325.302941] Call Trace:
[ 5325.304389]  <IRQ>
[ 5325.315794]  ? skb_panic+0x4f/0x60
[ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
[ 5325.319490]  ? skb_panic+0x4f/0x60
[ 5325.321161]  skb_put+0x4e/0x50
[ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
[ 5325.324578]  __napi_poll+0x33/0x1e0
[ 5325.326328]  net_rx_action+0x12e/0x280

As discussed internally, this alignment is not necessary. To fix
this bug, remove it from the code. So oversized packets will be
marked as CQE_RX_TRUNCATED by NIC, and dropped.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network A=
dapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
 include/net/mana/mana.h                       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/et=
hernet/microsoft/mana/mana_en.c
index 59287c6e6cee..d8af5e7e15b4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -601,7 +601,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, =
u32 *alloc_size,
=20
 	*alloc_size =3D mtu + MANA_RXBUF_PAD + *headroom;
=20
-	*datasize =3D ALIGN(mtu + ETH_HLEN, MANA_RX_DATA_ALIGN);
+	*datasize =3D mtu + ETH_HLEN;
 }
=20
 static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mt=
u)
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..4eeedf14711b 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -39,7 +39,6 @@ enum TRI_STATE {
 #define COMP_ENTRY_SIZE 64
=20
 #define RX_BUFFERS_PER_QUEUE 512
-#define MANA_RX_DATA_ALIGN 64
=20
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
=20
--=20
2.34.1


X-sender: <linux-kernel+bounces-125448-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAx0emlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAI4AAADMigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 20009
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:38:12 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 22:38:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C7592208AC
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:38:12 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.85
X-Spam-Level:
X-Spam-Status: No, score=3D-2.85 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1,
	HEADER_FROM_DIFFERENT_DOMAINS=3D0.249, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Dmicrosoft.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JptOlX0h2SFT for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:38:12 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dlinux-kern=
el+bounces-125448-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1116620826
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1116620826
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804A61C20C8C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E313CF86;
	Fri, 29 Mar 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dmicrosoft.com header.i=3D@microsoft.=
com header.b=3D"fYd9G8pK"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2az=
on11024030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2761DFC4;
	Fri, 29 Mar 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dfail smtp.client-ip=
=3D52.101.46.30
ARC-Seal: i=3D2; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711748262; cv=3Dfail; b=3DiZ9ijgBMrEzSwGtKXfCOIIz5l76jgxQxCztwzrsr2v2=
tWGePAS8B8YbYCP3O23qo8FYz/wSJE3g7clJOMaUxLNYVpCgfRw3Ao25ru5dRg8i4Yy3B8FeH4T=
vtxLNPRXNsgutNfae3/nHsP9bly8h7xlhbV2C/ix/HRJLkrVVeIS4=3D
ARC-Message-Signature: i=3D2; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711748262; c=3Drelaxed/simple;
	bh=3DS6L0aMDSpr9JXtrGomNM3mxeaZv0TjafWVbFhd/0rqQ=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=3DgyME=
QbOJCv84m0pdHazmbwakaOv8XxjfD2pmSbQoPswacqg9FURsA6qwZWu0Hf+sqEsyw9Y3OaABpf4=
DKmofitkdFyagF/fpLKUormXXIbj3daiLdi8HdnRZITCLo1H7Q01Qs0yzYIJqbaUpMwmqsLhj0M=
OOVHTkMR5biqhYU+k=3D
ARC-Authentication-Results: i=3D2; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dreject dis=3Dnone) header.from=3Dmicrosoft.com; spf=3Dpass smtp.mailfro=
m=3Dmicrosoft.com; dkim=3Dpass (1024-bit key) header.d=3Dmicrosoft.com head=
er.i=3D@microsoft.com header.b=3DfYd9G8pK; arc=3Dfail smtp.client-ip=3D52.1=
01.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dreject =
dis=3Dnone) header.from=3Dmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dmicrosoft.com
ARC-Seal: i=3D1; a=3Drsa-sha256; s=3Darcselector9901; d=3Dmicrosoft.com; cv=
=3Dnone;
 b=3DG+up8M1R6nWQO0DXaYd+wBDKKGB1/bicu40p0/YdAkv5mb6OJWhdTlP17CsBYvU1cTe2Vu=
1zbbW6YoTYwwd5z7S6kl6IQHUEC0jVb43ZLNW3tj7LDj2raILYWoEZYKLAH9zyXdXnOl7SOSi3s=
ysssQobfkShSKfrG7Ryok6ZfoZRaqFJdOUtSMhassJPjrGCVm+vRhZP1yAdu4Hvy7HqUlMb1DRI=
tidTQpQVxDQySKDKS38WWy7J186NC3WxvAIPzpVARGxDwaEZsEYY22ygnefkgr9AYW2iQBv1uoD=
T7TkXzNnCi8BQr5901BOXsVzNRVC6Lvxdp964ME/YMDJgTA=3D=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dmicr=
osoft.com;
 s=3Darcselector9901;
 h=3DFrom:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-A=
ntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Ex=
change-AntiSpam-MessageData-1;
 bh=3DMfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=3D;
 b=3DaUj3LJd3Ycvr0X8wVDCBA+o8mkkhLHtN9ZiOsnIh5olXttKBTwCbXIRoC0lcxj1hw0EqW+=
pqkqEN+8c1JJzbZZOEE0/7AAhxsiOgWLO+UHcuX9Js1Vlfqv3C6A8O/8l0hWiUg1iDBDAzao1x2=
NJAJKy/8u8Jsf2Df1QEtBzIafwlUZdCJyLIUO1dpqnbrtFXnwmCyLPFFjbr5OKs3ElFhkEqsMpx=
krzN7LpbuZ+by9Wdx5f8yztSBYsoPwiZo0DODN70WlrBNZpJXqkcFghQWiSDWgY0urDSSaq17d/=
MtOnED8MC8FEVqXr3SQEDi/13645W+q7K/XJ4hxyxUQKEFA=3D=3D
ARC-Authentication-Results: i=3D1; mx.microsoft.com 1; spf=3Dpass
 smtp.mailfrom=3Dmicrosoft.com; dmarc=3Dpass action=3Dnone
 header.from=3Dmicrosoft.com; dkim=3Dpass header.d=3Dmicrosoft.com; arc=3Dn=
one
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dmicrosoft.c=
om;
 s=3Dselector2;
 h=3DFrom:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-S=
enderADCheck;
 bh=3DMfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=3D;
 b=3DfYd9G8pK/2EHHOyku2boMZZTEYjJil93H8Okh3VJ+6wmjgw0AN9tZ4ZdDJdGMumeTHFSqQ=
0bEwApO+U4Sh1kSdhCXJFwpcrEL090BWAyTVunPzM9/Y9HoAXH0hDO86WeTR0EFfigssLcFOoaZ=
UZSVPNtGOVcFLEhnLmCB5bLOAQ=3D
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::=
18)
 by SJ1PR21MB3483.namprd21.prod.outlook.com (2603:10b6:a03:451::7) with
 Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.14; Fri, 29 =
Mar
 2024 21:37:36 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab%6]) with mapi id 15.20.7452.015; Fri, 29 Mar 2=
024
 21:37:36 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <haiyangz@microsoft.com>, <decui@microsoft.com>,
	<stephen@networkplumber.org>, <kys@microsoft.com>, <paulros@microsoft.com>=
,
	<olaf@aepfle.de>, <vkuznets@redhat.com>, <davem@davemloft.net>,
	<wei.liu@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <leon@kernel.org>, <longli@microsoft.com>,
	<ssengar@linux.microsoft.com>, <linux-rdma@vger.kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <sharmaajay@microsoft.com>, <hawk@kernel.org>,
	<tglx@linutronix.de>, <shradhagupta@linux.microsoft.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Date: Fri, 29 Mar 2024 14:36:53 -0700
Message-Id: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3483:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ku/LBwCcqrbaEx6WajYxO2bJE1wRc1/UmkkB1NQ=
jnCLJv/iKgt9h7GpsW+ghqYk02boFss1T8LHLMKhIRzRY/33/YzLMxLUJw3lOXSlJ9U986LDKYq=
hjGpDgeg2rTNL6GGV7W59dbgTAyGUmtoOhyWIJR87QK5s2Zy5yCCMnFMNPINGcyybxpNMIGU6rt=
fhrWUD2VhNKIZWC5uM4Hlq0U5hc2daefmZaN4u9+a0xsfB3W4PPXcKimkfQwNelA3wmi33J+yi7=
4mq/oMcjp79R6GECaUFmxYh0W9k/rV5eNaU71QLByO2nwZROkj6u3AOd9c4q5nUJLI1GTHWbCMY=
6d5lVHFaU9sF5rcOwP3JLUcWuNckouUW/3ibxfUBslG9+w2aANVnFa9PvG3J8kmqEtKqOf6GAEX=
H6jCT7F88w0KSHA747RtIsP8KSFWLFC2r/6n0vdOGP7UdGiNUpby/OCQAyDD2yCe77C0fnFLhpE=
J+yLaCXv3P7/whpDFta9pzX4QrthuFKRTo5zP3CB4IwUhUess9Wk+EUkcMq/Hww/27g++JIPQky=
IhCsthN5ikSoMn9XFqXhhW0M57njmQn3ZMN/Bt4UKvs98l968yZoWZ2XXgeOSypq9OfrwVR9o7Q=
Zf+/pOA18a9pBJksxOdHI+lK6gJXL2o55PIGmH18Sgo//MXWhHoAN/8yp+PcRFkfOELKdetoyC2=
P2RkcgIGFUKIDljA8iVtUEx4HikFzEAw=3D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;I=
PV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS=
:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR=
:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =3D?us-ascii?Q?RRifRCih3C8HkWBa8isOeD=
8NZLiEjS6Sx0Ha6ACgXSDSbbudtEc4pY7tMBWP?=3D
 =3D?us-ascii?Q?AXPuUNiTlJzCDh3KZ0krvkrrmbVW6ubMf7utbQ5GdifXuPwzaj4hHTATyty=
Y?=3D
 =3D?us-ascii?Q?wfUElHzsJgdqBlkYD2l5Z9nBQyUKVtcC9/91I9RtMEOnX/Qf7c8lb+tHd+5=
i?=3D
 =3D?us-ascii?Q?sdtDOAQcHI3nZqEo0/ZBCeSI+eKe4bxYqskPqpNt2EOjmoonoq+pw8Y8i5+=
A?=3D
 =3D?us-ascii?Q?z7gyHg+Up6p+nbetWV8Ztyq2J30/blP7zyzrxcFS624iyKQ5jN5GlKV1sJx=
Q?=3D
 =3D?us-ascii?Q?Yv135/UYBX7n87+EGGW/9hS7O+vOpJV2jkbWk0CPAtNi0g/o7J15TePfYpp=
p?=3D
 =3D?us-ascii?Q?VghHsNq6ouqc8Z+Wjsyhph4Rxe5H/PDNZzRKOe+i87Wk9T9XL4UGgLz6KJv=
f?=3D
 =3D?us-ascii?Q?yDP5Jts6TF0jnJl0O8Y7c28SCIxJNBtpthTXQnxuruVBwtbpIWQTJjTONR0=
7?=3D
 =3D?us-ascii?Q?Q05b/bVl4TrHIsdURrX56B+vn/t6UU+Mvc3wnH3ywN+uPzRqNu1VHlSGft2=
C?=3D
 =3D?us-ascii?Q?7jjoL+twQfrW6QwFSVSBJJZDqjXQHTssVD+SAJsDgkociG/hrhAz5q1V721=
m?=3D
 =3D?us-ascii?Q?5tIaGkClBT62EOcXnNUSrb1UpDgaA8aVbn9VxivjhiHfMO6pylv2aIK+4yM=
Z?=3D
 =3D?us-ascii?Q?+7LCrKz7IzdC/LtUl/s4HJ73wg0TjFXI/8LdMGaMMSDqPESbMCeHTJqTr7b=
M?=3D
 =3D?us-ascii?Q?0iAkVYn1BwdQvdUi1F4fCRIvDSDf/usQR8L1jGm4L8h/zW2rxmn1WtRWZZT=
N?=3D
 =3D?us-ascii?Q?NL6gZEYDamc+Ogd6G+PpEgBGFJ1NOJhIhNUD0L0/WLTO1iMZxoOV8aJodCg=
r?=3D
 =3D?us-ascii?Q?14jFdr2sIl4tetbQxXN/lnEEYKEz+neUSlyVGlOuvVZ+eE/6oPRNbj0aTCr=
3?=3D
 =3D?us-ascii?Q?hRkJWh/eBah/Ye3UpPgRlHgJ0+2CK/8Hcb0j3W2qMneCDNyc1Duzx30r714=
r?=3D
 =3D?us-ascii?Q?hVnwMM92AvBh4zqJRTd0/Sdpyud9536MHJ7NV6+5Qy6MCS7akyLFfIoW3Tt=
h?=3D
 =3D?us-ascii?Q?qeBusz54Oh0Yv2jo2BzHfE+w//n5Ck65WwYFqY75UBO90R+UTsSatlE6Yp+=
z?=3D
 =3D?us-ascii?Q?VLQyccetYjE29NvHb5lODYNJ+MZVKy865+aO4VNkL/y/YMUHtSRT5wBztIZ=
b?=3D
 =3D?us-ascii?Q?AAkd3ZIQCDQ70+53B+/GcIjZE/rLn3gJKzfHNZusXsjcSZ6BXrBMMXzV5/X=
f?=3D
 =3D?us-ascii?Q?6iu/ra1IeHLp98NybXOr8osG9W35BVz1zKYVfCVuzP7+L6fi8ezyWZYXJLe=
e?=3D
 =3D?us-ascii?Q?gfU602kWOMB3mqlAcsdpN49m/+CYiGXS79DLXkgs89ZlcxGiFN1u1p/c/Qk=
P?=3D
 =3D?us-ascii?Q?1CAoQCb1U/Bb9DIJqmn+xjXyhbONwRwbQ/fx3fAFuzQUve1dt2g5+fs2yVP=
8?=3D
 =3D?us-ascii?Q?7egUEO9oLwNY3qQH+zRxTBse2w4maiFr45+/tc5DuL1tu09A0iwksVFzu7O=
N?=3D
 =3D?us-ascii?Q?4VItwdDsp5ScS7EQbwD8G22yOFUS8h3amjS7SWkm4Iax1LGaexrf1EjrKV9=
0?=3D
 =3D?us-ascii?Q?ANSX8G2E3wB+LK8/jNpJbFJ+/pcYobj8762g99YqkbdQsGE5LwebyrV7Zt0=
E?=3D
 =3D?us-ascii?Q?90rCt/vq117uE//06IlTzmUNPqJIqchODzyFb7oG?=3D
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d1d7b-73b5-462e-bfb8-08dc5=
0387312
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.c=
om
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 21:37:36.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nUR1qXP88MO1DAlmIlbknB4ftO0Uu=
N97J7nsOcGE5t/lRakagsLUVErp3YlCGNIkfx0TlaJKjBWQsFwXnKwMA=3D=3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3483
Return-Path: linux-kernel+bounces-125448-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:38:12.8363
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 78e3b5a0-5be3-4d24-8021-08dc=
5038891a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.215|SMR=3D0.137(SMRDE=3D0.004|SMRC=3D0.131(=
SMRCL=3D0.102|X-SMRCR=3D0.131))|CAT=3D0.077(CATOS=3D0.002
 (CATSM=3D0.002(CATSM-Shared Mailbox Sent Item
 Agent=3D0.001))|CATRESL=3D0.026(CATRESLP2R=3D0.004
 )|CATORES=3D0.041(CATRS=3D0.041(CATRS-Transport Rule Agent=3D0.001|CATRS-I=
ndex
 Routing Agent=3D0.039 ))|CATORT=3D0.005(CATRT=3D0.004(CATRT-Journal
 Agent=3D0.004)));2024-03-29T21:38:13.096Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 15054
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.043|SMR=3D0.005(SMRPI=3D0.003(SMRPI-FrontendProxyAgent=3D0.003))=
|SMS=3D0.039
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAfAGAAAPAAADH4sIAAAAAAAEAJVWbVPb=
RhA++d0G05Rp8y
 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
 RmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4w
 PC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFydE
 luZGV4PSIxMDg5IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVt
 YWlsU3RyaW5nPnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc8L0VtYWlsU3
 RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5k
 ZXg9IjEyMzUiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haW
 xTdHJpbmc+aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbTwvRW1haWxTdHJp
 bmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0VtYWlsU2
 V0PgEOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldHJpZXZlck9w
 ZXJhdG9yLDExLDI7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDE7UG
 9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2Vy
 RGlhZ25vc3RpY09wZXJhdG9yLDEwLDI7UG9zdFdvcmRCcmVha2VyRG
 lhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJv ZHVjZXIsMjAsMTk=3D
X-MS-Exchange-Forest-IndexAgent: 1 2360
X-MS-Exchange-Forest-EmailMessageHash: ACD98539
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
can be received and cause skb_over_panic.

Sample dmesg:
[ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536 put:1=
536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700 end:0x6ea dev:<N=
ULL>
[ 5325.243689] ------------[ cut here ]------------
[ 5325.245748] kernel BUG at net/core/skbuff.c:192!
[ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
[ 5325.302941] Call Trace:
[ 5325.304389]  <IRQ>
[ 5325.315794]  ? skb_panic+0x4f/0x60
[ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
[ 5325.319490]  ? skb_panic+0x4f/0x60
[ 5325.321161]  skb_put+0x4e/0x50
[ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
[ 5325.324578]  __napi_poll+0x33/0x1e0
[ 5325.326328]  net_rx_action+0x12e/0x280

As discussed internally, this alignment is not necessary. To fix
this bug, remove it from the code. So oversized packets will be
marked as CQE_RX_TRUNCATED by NIC, and dropped.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network A=
dapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
 include/net/mana/mana.h                       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/et=
hernet/microsoft/mana/mana_en.c
index 59287c6e6cee..d8af5e7e15b4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -601,7 +601,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, =
u32 *alloc_size,
=20
 	*alloc_size =3D mtu + MANA_RXBUF_PAD + *headroom;
=20
-	*datasize =3D ALIGN(mtu + ETH_HLEN, MANA_RX_DATA_ALIGN);
+	*datasize =3D mtu + ETH_HLEN;
 }
=20
 static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mt=
u)
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..4eeedf14711b 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -39,7 +39,6 @@ enum TRI_STATE {
 #define COMP_ENTRY_SIZE 64
=20
 #define RX_BUFFERS_PER_QUEUE 512
-#define MANA_RX_DATA_ALIGN 64
=20
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
=20
--=20
2.34.1



