Return-Path: <linux-hyperv+bounces-1824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFC88A378
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 15:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B347D1C3A277
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFC14600D;
	Mon, 25 Mar 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HLN6HlwQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A1145B29;
	Mon, 25 Mar 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359608; cv=fail; b=TDMXYuHdebQccox2LXCsaGbknwc5TmLpSmtW1PweNbYSHIUibioT7cJIdEvSKboQZ3fucj/DTsRjLDhgllWRXXg+gO/2fLFZ9/Vzj5nhqaau77GbKLUmwQU+pp8IECfeECr1J8wyZndvqzGqR0cq8BrBUJCreesKRX/xPGM5/84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359608; c=relaxed/simple;
	bh=Z/5xlqoM86PbZ6pyYYzGmk7tZBzKI7XiMVMWlvi9/5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPXhXne5C7KhB+6EzwZoIoz3eeJY5fURie5cVvRRnIYDP1zTO+QbTCIO9r7vgRVN/lXz/WzLOCYIm2P7ZcEOz0rgRMOpIXUg0hneDn10/2+Xm7Bwr4vNf124rSR9PjxniL9SeV1fF88t5dLO0JTfubho5F1GjS2mlRbiNM71Y78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HLN6HlwQ; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711359607; x=1742895607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z/5xlqoM86PbZ6pyYYzGmk7tZBzKI7XiMVMWlvi9/5Y=;
  b=HLN6HlwQP/vq7g6lPHsp3iFnP7RD/H3xmOnXZaHxUpDHwPapTNVxHxge
   UEtwN2FS+/YdpXyY8nLQca3zSMaapVkVu8wmJ6MyByvSIK9VQ3UCKOocc
   Luji8N71Jh+ks8fbzXJ2XZPMWPkezn/1ydR5qOuXHl7uEMjvuEW8IPAiX
   LNlmIsFDc3S3Ye+e8fu+74+xdUImnhURjMWGBCLWgYnb1BJtXXSJdTRza
   iJO0NCHr4QHCUSD5+cxS7I0QtTY94R7Z2FgEcZ+oQmyobJZuvVWiGqGwW
   fNcjf/6Tdvyp2sXfOhw1SMGicVPcYRxXzoe14rKK1EIpRVr30FBtSSt9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="114950600"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; 
   d="scan'208";a="114950600"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:39:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVdF7RFuK/AYuqggDRIcBYnOpaHt+bT6KI1noXJye1mMxtBzM0ZJq530Y5XuXrTo9PnUMDhtumvAIL3IkNEjK430XKHOI97A3JnzMo/0MalReZiBaXcHwtxh8PQJSALR3/iVePsq0MyEtgEsKlRmusih/R3vQ9eG4L8p6Vl/Ex1/g/XDJaeUarhBpa6YeeBaQVrzg0dDfW96UaPoKBVo7It6WGvvHKV9VNoptlBZy+x9G76gobxaBgHOHxi/lw8GWTgka3Cztmf4TwpsLQmtn2bV1hKY3EB2WYy9OUPdqpYFcfnxnKYF/DrikiWk3vqxmY5KNg+V8j5RDrW+J4vVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/5xlqoM86PbZ6pyYYzGmk7tZBzKI7XiMVMWlvi9/5Y=;
 b=SJEtnCgDIc4wCU19uOpS8OskHRDrLVfY0isEnPYPd7xedmEzuDUrOtNVpIS7U7+TJde059tesBAM8uYR34FBbvv1GbBBbbvyP8pzxxzx4WKvZzOIj2Vk1PpZ7uoLUvznKVfrMbrUrQGxa+SrCpam7013s6HlJP9ktMEdgT26GtaduupnmCjEAYKJEfc9eJcxtFkLpmR11TT10lk6GEwlYT0mT6RVFcnUN3GRC4S2ZKHeeA/aYdxeNAEq9zRxJOFpN1uPmKbH8rM0X1bmogfhWvbPdq4tOFCK7Ejn0g4u+pTh+vK930Yf6P/H7g0yC95KnUo8jIhw9F/+SbzutuPgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYYPR01MB10593.jpnprd01.prod.outlook.com
 (2603:1096:400:30d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:39:52 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:39:52 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Wei Liu <wei.liu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit()
 family
Thread-Topic: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit()
 family
Thread-Index: AQHaea+sGRGDRSgQ6kqU8QEjVmbOQrFEcIoAgAPM24A=
Date: Mon, 25 Mar 2024 09:39:52 +0000
Message-ID: <5c1f6aba-bd3c-438c-8e00-548fe29d8136@fujitsu.com>
References: <20240319034350.1574454-1-lizhijian@fujitsu.com>
 <Zf4WUMyNq38LyDLW@liuwe-devbox-debian-v2>
In-Reply-To: <Zf4WUMyNq38LyDLW@liuwe-devbox-debian-v2>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYYPR01MB10593:EE_
x-ms-office365-filtering-correlation-id: 95affd22-0669-410d-57b5-08dc4caf85e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YXnNG+oEBpuLFK4OwBO2G0f71a0JAFhlym1Pz8/c1vZkjHB/DdIHeU2JKhkk/7si6uvyGItzpbNOK2mfw8nSb2tsY9AZK3OyjXzfWIGaIZpfpN60K3cY8nVKSN9EqdozAtMLqA3pf+3KgEd+6lptCxYGWJUt3Blz2GoeXnd9wk5ohdL/rhxzuF8f79yK0JRIRgxgyM/x8taQWHlKSuw1P44ubFtHE98y9KBn/rUrfoSFgzQT1J8MmCJkGg6R9Fqpu4cdlqHE9ypQu4RSm229oXU2awO3kPvk1WM88I7c0nhI3Q5oNswfpOZ8ygkPkWtCsuwiN7NLfZSG62D8vWt/FDUiJUNyFcTpxvYoGdBd4fCIWdx2f3RRK+ppvKci3Kunxe8egoFL6mq7uIdVWU01hkVvuRqRXRrYKQ5zb42oJtBLmypf89fjp4DGWDavgvY/e9wRGVCOWdF+jANIn0Q9R2Yq0z/O7Q9TVa02XXqeQ8A/rx+5zl6zjgqElLqkv9JUdHVjvvWjDrmOjclfISCbZhNJD9hSOBMlOnvLlHzsWOIsXPrj/mJJXgFV/3GLigxvnv+Wnhq5PqN2VSCL6SbJiyU6o7WlpFd52Z/aV+AXo69nrx4jfixmK5boNwuiWX3Wq3MOnd1c9r2/g0Rl5ZQ784aKMTT9T1DXgjTNHqCe2AyWFrMN4WlSaAHJkl8AnmvKxYP6AHZFlFmrZZGqORlJps+J0T9O0FHJgJ/6Emn/Y/SrG+PqH1YTuJPwjgAunLlr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHMwa2s2VnBuUXVkbVF0cklqbWs5K1BhMmZibFVDMzIvSzVoTW1Ddk5FMDZw?=
 =?utf-8?B?cnZMZUpSV1djYTNuNVNGVzZtVG1Tcm5RWW5nNDBQVVpxT3pSSTA5QllpK0FL?=
 =?utf-8?B?dmYrcXYyRXRyYk0xQ3NCaXZnV2sxQlQxTTNHZFBOSTBXSFdlUjZmMEpQZU1w?=
 =?utf-8?B?RlMyd0J0QTZXY2pNY1lCQkdpT25GWlRtQXlXQUhkTVNGTTlPUGtwRi9RL1NM?=
 =?utf-8?B?UjBBOFoxV0JUR2VzSGQvVnlZUEJ4bFNBT3BsaExyc0xCa0xZekZiMExuSFJr?=
 =?utf-8?B?Umo5M2hma1VmR3hnaXJsOHFKZUdrZHVqNmd0bklscUZDejQxUjRHbmM4TWlI?=
 =?utf-8?B?d0FnQXBlQldyQXR3aDF3ZDVzTTdkeFV1K0xaK2g0TjI1ajVaakszdkcvcDIv?=
 =?utf-8?B?dDNINzVrWU12Tzh3MitxRkRBZHRCckdJYkhmVk1tTER0Zm12ZXk3ZGdQeDV4?=
 =?utf-8?B?VlNhTW0xMUxmcW9hbzVXWTBaY3hGSXk3bGZWR1U2cHNOVTRaUzdqSmJDZkdq?=
 =?utf-8?B?K3dvNnl4K0o5WFVvS3NmWDNpanhiTFdzUlZUakZZT3NiVWRCYlZhVmdCUG5W?=
 =?utf-8?B?TmxXM3hKUXdsMWpKY0hkT3BPZmtwRDA5TkRpYXZqbWdjSmY5c29kRjRPSU1q?=
 =?utf-8?B?Nkt3YkJCcUg3bVdJS25RWUowOW5xenRkMjBEcnRhL0NTaFlYK3ZXQTRzK2JO?=
 =?utf-8?B?UWNmMnVUbW9yZStmUjNsaUU2UERNcjR0c0xoWGt3a3pRK0t5VG5NTG1EYk1N?=
 =?utf-8?B?SU5ydWJwNHFQbTRqZ1FENXkybTJaUFBrZVBteEdjQVJIWEdmQWVrS1JGSnoz?=
 =?utf-8?B?UFlkLzFJV3Yva1EyWjNuNkw4QllZbDVlZ2FFK2RPNWZSZWFCNHFvRTdCbHBv?=
 =?utf-8?B?RUMwWERXTHB3ZFhVVVJZekZkejIvRVduZ0ZXTUN0c1hNV2poaWhwTEI1QmRy?=
 =?utf-8?B?QTlJdjhILy83bHVmdklPUTM4SjhrKzZXeHVqYmJHVGVCQVh3VVQ3eGQybmlN?=
 =?utf-8?B?RkZ5U1RxaEhFbFc0d0hwdkFCR2ZlTCtjMERlbUt5TFU0NDZLbjZGaFJlbm5j?=
 =?utf-8?B?ZzNiUFRqYmdxaUovVzRxYkhwQjZaaGozSGx2TC9HVWM0RGI2TWhhcU9BSFAw?=
 =?utf-8?B?Y2M3VFhsb2tBWHF2bmpaQytMTFdUWFdqSlhaenVVTS9XSFVNcDREY1FCZGVZ?=
 =?utf-8?B?b3l5eS9KY2JleFlVR0hMbEV2UWZMTFoyNjdqbTdRa2N0Y09UblJDMVNzdnVj?=
 =?utf-8?B?V1krUDVXdm1Wcy80Nk5ESzRrOWd6QUxid0oxUTIrUy9mcHZlUXRCUkRZQjBQ?=
 =?utf-8?B?cjdRamgxa2FlZDFCOERldlpLZXJrdUgwWlpuZFo1dndKbFlsQWsrS3ZwRzdr?=
 =?utf-8?B?UGlqOWM3Rm5IdC9KMGVCUDlTcTVSOHFDWEl5T3RPQ0Z3bS9qVWZaWW4yTFVm?=
 =?utf-8?B?SHlLT2RReDl4aFIybm1RR21mbzlxSUR0bks4N0tpengrNG1YcWdrMFZqRG1M?=
 =?utf-8?B?Z0ZIbzlWODFWM2s2RzZSUUhBM0U5Zi8xODBZVFNaMkJDcDZhWkR1SFZrRG9V?=
 =?utf-8?B?WFpPd3BNNGQvc2VOVjNkZExPUkxDS3grcldIbk9QVUxZZlZGNThDWmJiSW5o?=
 =?utf-8?B?R0Nra1F1bUpNWGNtb1V3bXhsdlZib3k5Q2c5TWxLTmJ6ZnNvdkNZZzNvaWRp?=
 =?utf-8?B?UEtwL2VLcU4vQzAyWTRwU1pvQTY1VFE3WTNHQytXb25uYWE2US9VZy9rWmJu?=
 =?utf-8?B?Q0RLSStXaE41YkFIWXJDOVpwYVFXYjNtOXVCMytrTVpJcEZiWmd4eit0T29D?=
 =?utf-8?B?anZBMi9XdW5VSVlYL1JVN09wVm8vM29rVXRSS0hIZURIZXVyU1ZtZmZnR1Rm?=
 =?utf-8?B?MGJDZVl3S2xpZnNPQXdvUkZPRGlocm9yMzFPVjkySHE4UEd3eE5JN095ekYy?=
 =?utf-8?B?UTZXWGhGL0QyNlQwUkRpS202UVErMW1HQVBIemJiSlpDZ1RrSGVHTkFyYWNU?=
 =?utf-8?B?K1dQbGR4MTA4ejkyWXJuTURkV25uTGQrYTA4YmJ5bTV2NVRzQzdHQWFkL1I0?=
 =?utf-8?B?QU52ZHc1OFRKdExYcmhNWnhmOHUrTFZJdHFMbjlxcHRUcjE5cTRDSGtTVVRv?=
 =?utf-8?B?RzNOQkRwYWtzUGd1ZFVvZUsxVEVCNWxRWmR0L3UvQ1hOMlBPbU9xL3ZNMlJj?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <643D9C6F1962174A8B82D5CC9597722A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MY/3nN+p9kY+C2xtS/29tGneS9VcrL1ueEJIV65XA1rx+xuDZ3xVamb+Sbr0YvcaiPf74+HHimMu5yOqcAF9p0I06jXO4IRDEemaS4hqYCmx1cjtDdY4z+iFghxpGXgKOX9j4ntDJ9QjwxnGATVktcCrowrhkT5FqFRFcuXptcx0qHHMbukzegymn4WcskrJJrtOoeijzC3S9GXf+mwFuWVb81Wr+Tg34a2H+oh3uDJUJxsMnuvlmOq1vQuw65n0vYJwTUU0vzgc140qvJGq6EbkSm5jg4kS8WUlXKEVGyiXfIXPLO0t7ny7RlkZGNDTrjV8oucDMAidz8FokFS8+wiESC5yEoYL9MwDygO98nT3CQBTXkbKeISfyONTzZYfxn5Qrj7nAZ7+hyhqNx/SVVwkhDTlpSjPMy/AFgiQwjAm7Gl+XyX/Czr+gJoQ0Ux0q31D2rmtSW/8M6kNDeSStde0Ohp3gs3b7Z3ch+7l2Wd8Y1PYswDXGs/SEkxYXYgNkKKEGEYpM7hWwNluuK3p7BwaLgFSn42ST80jSiEC37YuQnJkpAWBC5G7MJ4VY6wF8aLzLVadk9TQkAxJK6haOdza3wGdol0gdoYZUY+8EBXRkZRHyOgqqkgVaQo1dABh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95affd22-0669-410d-57b5-08dc4caf85e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 09:39:52.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZHWFh2J42p/r1RclpvQL0rXWKhPM6hQFFSejz722FqTyBEo1ZLPZ9WZ3s4cHY0tiv+TYongcPDN5kLtCi4e0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10593

DQoNCk9uIDIzLzAzLzIwMjQgMDc6MzcsIFdlaSBMaXUgd3JvdGU6DQo+IEhpIFpoaWppYW4sDQo+
IA0KPiBPbiBUdWUsIE1hciAxOSwgMjAyNCBhdCAxMTo0Mzo1MEFNICswODAwLCBMaSBaaGlqaWFu
IHdyb3RlOg0KPj4gUGVyIGZpbGVzeXN0ZW1zL3N5c2ZzLnJzdCwgc2hvdygpIHNob3VsZCBvbmx5
IHVzZSBzeXNmc19lbWl0KCkNCj4+IG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcg
dGhlIHZhbHVlIHRvIGJlIHJldHVybmVkIHRvIHVzZXIgc3BhY2UuDQo+Pg0KPj4gY29jY2luZWxs
ZSBjb21wbGFpbnMgdGhhdCB0aGVyZSBhcmUgc3RpbGwgYSBjb3VwbGUgb2YgZnVuY3Rpb25zIHRo
YXQgdXNlDQo+PiBzbnByaW50ZigpLiBDb252ZXJ0IHRoZW0gdG8gc3lzZnNfZW1pdCgpLg0KPj4N
Cj4+IHNwcmludGYoKSBhbmQgc2NucHJpbnRmKCkgd2lsbCBiZSBjb252ZXJ0ZWQgYXMgd2VsbCBp
ZiB0aGV5IGhhdmUuDQo+IA0KPiBUaGlzIHNlbnRlbmNlIHNlZW1zIHRvIGhhdmUgYmVlbiBjdXQg
b2ZmIGhhbGZ3YXkuIElmIHRoZXkgaGF2ZSB3aGF0Pw0KDQpJcyBpdCBoYXJkIHRvIHVuZGVyc3Rh
bmQsIHdoYXQgSSB3YW50IHRvIHNheSBpczoNCg0KU3ByaW50ZigpIGFuZCBzY25wcmludGYoKSB3
aWxsIGJlIGNvbnZlcnRlZCBpZiB0aGVzZSBmaWxlcyBoYXZlIHN1Y2ggYWJ1c2VkIGNhc2VzLg0K
DQpTaGFsbCBJIHVwZGF0ZSBpdCBhbmQgc2VuZCBhIFYyPw0KDQpUaGFua3MNClpoaWppYW4NCg0K
DQoNCj4gDQo+IFRoZSBjb2RlIGxvb2tzIGZpbmUuDQo+IA0KPiBUaGFua3MsDQo+IFdlaS4=

