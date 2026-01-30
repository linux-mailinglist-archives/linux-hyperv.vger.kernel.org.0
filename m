Return-Path: <linux-hyperv+bounces-8603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLsrNzTlfGlDPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8603-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:07:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AFBCD23
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A5E302A044
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C143563E7;
	Fri, 30 Jan 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W0V9V4ZH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012051.outbound.protection.outlook.com [52.103.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A93557E7;
	Fri, 30 Jan 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792573; cv=fail; b=LGOi0b2Ijqd5tRtt0WGjZFIgp/7m1SD2AnXG94kL7jfvhU+yzEcmCM5OExB1hM8Ur1DnIBmiRP7rHRl8axPLn8cGTdJMtsNteIkNuAmzMH3Z+C9jwSAaeWBvpPNM4C7lDItR/7DCgtXBjURMu7u1YbqeQh+mZc5uA8c5DW2pTj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792573; c=relaxed/simple;
	bh=ecn0as81ESxyO5imFQdZxOetnV1ikfE7apdBcdlFUrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgK0CLtyqeGPxrJHujP0Y+CwEHhzdZYwLpjSCd6OvSwHdqpWmknfq+7QghH+GZfQ2UzAjO1/irdHCVUAGCDo3elBm5sd0SRHWzYLsWzYPrt+hezXyje/2l4IpUrpDlW21cMXiEGkiA4qXhxljxS7AinBDM8eipFS8l7RciDME/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W0V9V4ZH; arc=fail smtp.client-ip=52.103.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYEUdQw8dESRYbo1e2+0o+a6STITR3TuksEgGNnRqsBFNyLINuNdIjKe/Nsaq4RIdG0dwiEhd95dPtItkUhcS9XdOvgX+qRhkBDUhGjYxQDqTFT46lsGy7OlJGhKOcjKFh3Cajy1Uj/5k8CR5MiaPemA3L3sYvqgvxLkj0qtV4aJrCTqz/M3DD5xa7kov5UhiRb89wA+mCGULdOk1rjzoDg2ITEEVoypXRqOoAo/hYaQDu/yfOyZ76ME64zUR6TTdHckJwUtUlE9EB/Xg+fFdBAE2A5Zijb00i6nGVD4kcAaRrkXaC/V12i6de8QFVKbMZbMAFJ//45ftwVd26pWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecn0as81ESxyO5imFQdZxOetnV1ikfE7apdBcdlFUrg=;
 b=uqc+X9leZsplYR7hgOzM+IGb7bojFyzKZoV9WpQizkkoMfP3G5mzSKkoS7W2iT4DMHzoWJEylXxoptYLZR8vYvnb7CiLcnr5qdYpO0CtocoIepmb7ivgL2+FFQlkuftbN4VIUMLLEn79r5FH8umszIWcBa+INSu99KRCYaKqPremjltc2ncAZL3lgtcAF1+MJk72jtrtPjp5ZjW541YLCNkWVgz4U3TUID2qZn+mpEAtBRRBmKb3lZ15UZdD5KtnY1ULbsFeB8kqzfQNZdcI0ExNrQY0zqCvufwGKJiFDeFcRtCiWeBCj0PB6iZSqRV+RIM+lgIQ63CB7xED7JWb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecn0as81ESxyO5imFQdZxOetnV1ikfE7apdBcdlFUrg=;
 b=W0V9V4ZHgwQiOsuf48lpBPWV/8YHkooLsnjlmPg23rDgw73cOgUcpy3pBY4zpdebJOhFuDw2CB/IWCMaNgAC88/zp8V46Iqnzo/IvwxJ6jJszWCV/ps6dEzrDsmVbxFU2C1nJ1AUbCvTrUc2A1mxFgn0anCf8HFzZFcS27B+PEtqT1hd8sYdiDNoDM/JXrrm4BXLv6jEX7G51AfAiV6ixtSJw/JXgG4Hpxp9i17jsmXqjr9Ynb9Zi8ifw9NJaAE8ydcfNqj8lnCvQzdRJIv/yCjAwnEAfiEVNBRPJ3PLERo7G0e7dWfr77sA6As6+gW3HCFBb6alvgukwbjm+ejpqA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYYPR02MB9764.namprd02.prod.outlook.com (2603:10b6:930:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:02:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 17:02:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mshv: Add support for integrated scheduler
Thread-Topic: [PATCH v3] mshv: Add support for integrated scheduler
Thread-Index: AQHckgJHZx7IYfaMKE2CkgqsEpEfmLVq8Hyw
Date: Fri, 30 Jan 2026 17:02:49 +0000
Message-ID:
 <SN6PR02MB41577D7BDB3BF3DD669CBBD2D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176978905128.18763.15996443783319253336.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176978905128.18763.15996443783319253336.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYYPR02MB9764:EE_
x-ms-office365-filtering-correlation-id: 28d441d7-2790-4337-e6eb-08de6021662a
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhEvpyeJ/Jdph30uiRXy5wZP8BnkkNTekwC9HxamvVxgmPf2pitbmgvEg+dqXBEi2QkCEzJmq4hgckrVpFgCiM9rmXEdrtEMVrJuJhoDA1jbBnZ03cm34TliuepvuYv++RHGwTt/CXtlrvrXN7HpPEiXLZVtD92PdOc4TK5GJLJ0O+g7nQ19JvSeoSUPg5P7Hn2tU7r5CpXz4aJVT5t6WftxiD7aor7WLK5P87/kLsxi/tKpGqTiLKf9zauRThJDDyo99xuZ9wd3qbuGlgtX6ylry7OMGodJtEj88Ko0fT9wzXUjXME8HFPYvorRwZtP4U7eynv1MSpsTo3Z2QYCc6uBekvkMNODRw07JSv5hPsI26j+nL7fdxFc34bIwLFk9Hak7fXxenHhQC4Eu7moYPUAo58lCHaZGH9cjPGSYygZWu5DgZsZMNPys5SyrfRS1I38oX+4bM4r9ViUcd0lzYG9ND4Bl/F7ECpDWAFRH7GTkJ0T8X4nXUKrRkbkHqa+MycNu3yAAmQlZDKCTQ1SuCzKumReqUTRdSRr4tYyPic9tGpE6ItRHsgY8NjjvmQ18IA+NHMJ/kNwcxoEu1uTFdCtA5XZiWyaBoFKfdbHHQuXclg5XOscVxMGyWXoiLC9+hQDTaoE7C2dmfmJs5SCqh9c+5QB62umrk8iibaTNk76IZNG14EofBqMztEq5wFiLvk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|51005399006|15080799012|8062599012|8060799015|13091999003|19110799012|461199028|41001999006|31061999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnJ6Sm5namI2NTVncUE0T1ZzbFNQUy9ReWtrWkR1UDN2VGcrOFlDVnNvUjU5?=
 =?utf-8?B?c1FCa243TGZyQ0VlcU9NcFBQZEtHbk1pV1FRczRqa1FzZ1o2c0Z5bVhJWVZO?=
 =?utf-8?B?dnJBTnJLVjZyYitKL3NDK1B3MHVMcENpVWM1OWdaMmF6QkR5cWtVQXl5alF3?=
 =?utf-8?B?UTQzdVhLbFFEUWI2TWZ5WW1teEZYYlhnOHIyVHE0V3dxMnJTeDhJeHc5dTZU?=
 =?utf-8?B?eXNVaTNlN1dRTytlbkJzc25TV1FFUHh6dWlrY1hyc2JpWGVlZUtlWTN0aDFx?=
 =?utf-8?B?TEliRmVBN2RzaW1EYlFBNFEyS1B0VDVZRCtNTVNBanAyS3lvVWVSNEJmT2Nt?=
 =?utf-8?B?OUdXMERWNmpvMWJ1M1lQQ3FyUmRJNG52Ymp1RnBNRjNaNGVOL3JzYVhYR0hO?=
 =?utf-8?B?U3ZqNFRhamhCZWF0SUl2SVAwOG9qcjJvaWlTUkJPWHdEdFpBMW5uWnV4dXR1?=
 =?utf-8?B?S2RlVXFhVEg3VDBnZm5iaGxwbkJPQS9VZUdzR2dWQzVkampsbUFvWXFSYjY5?=
 =?utf-8?B?dlZ1Q0p2K0JUMzFqUitMeU1uQzZURldyQmU4YlY3OGRFd2NzczE0VDZvL1lh?=
 =?utf-8?B?SFVYQlEzcTNnNnl3TjdLcXd3NkpLTGVFZ2pyYmFJZkpVOUxrOEdNRmNVMmFK?=
 =?utf-8?B?T09oOFRiUHdWZWJUV3p6YzFVNWYrQnR3My9UbFBIYVo5cGp4M3BhUGVnb09p?=
 =?utf-8?B?QU94bEpGYyt5UjdFZXhpd2pQYmhjZE5SV0lvVTRYZSs2VWh4UzFkTHk5U1kz?=
 =?utf-8?B?WUhqWXBKRjdNSTJIdldHWGxMLzBGZ0ttT1NWaGRiT2paWjA5RnFNMXZ6RUVD?=
 =?utf-8?B?U09oQXFZUzhPSlp2WmhIdlVjMWJDdm14aVludlByK0FNcmlqMUxuQ1RybGp4?=
 =?utf-8?B?c3dhQUo4bXExUEdMRmtDMGtGYk03d0wxM3hTVEZOaGx1STFRRGxjd2VyMzAw?=
 =?utf-8?B?bkl3aHltRWR1MXlwbGJQQ3JGSXJ6byt4YUZ3TlZsQmsyZjZja0hpT0xnQjRS?=
 =?utf-8?B?MGZZV05NZHFtZ1ZLR0lXdDZKa0s5QnRiakNJa3J6bjc3dldKYUxnVHZoemc0?=
 =?utf-8?B?dDBKbzNjVThOc2tUVkRyNXY5bEVlMktrNmJBaHJiSG5jQXpvcEk0R0ZxNitt?=
 =?utf-8?B?a2Urc2FkUFZ5clRUK1ZSMXpNR2NabzZuaXBnK1lFVDd2TFZVemVSMC9hdEZw?=
 =?utf-8?B?aENBTEc1bjBZbkM0b0xuNjNkT0Y4cFZEbGIzQWduQk9tTGVMdEtOcEtJd050?=
 =?utf-8?B?SHN3eUg3K0FwU1IzbENxWnovMG83UVN4YzE4Y1JFU3pXQ0NtVWNnYUxDNHZC?=
 =?utf-8?B?Rmcvdmk4T1ZGUDdmUEdEdE1VcFVxNkszeDI4ZWxHa0Q1aXJzN0lpVnNSREJ2?=
 =?utf-8?B?ZytjWUdxaCt0eEhNYndpMnFJdEdDUitXQjVkaUZNTmpzSHhDZDBnQkhEbmZM?=
 =?utf-8?B?aHU0SjBJR0RGNWFtcCtFc09QSzNvaFBNWXJEUE1aUURJTkRaMlNWTXR6R3J1?=
 =?utf-8?B?a2NySy9qRkZPWnBXUWxMVS9idzNJT2s0VDMvd3FuQVMyR3IraE4rRnJVbzJN?=
 =?utf-8?B?LzM5dnZpV29zZWNaRUhPVXFQT051bjhsTFZ6d2QzL0RIU3VuSVZpa2Fvdm1V?=
 =?utf-8?B?Mm9CNmdKNTYvdktiSFR3YUh5TEtkRDk1SmpJc0NoQmdZazZvOVBUWFM5aXgr?=
 =?utf-8?B?YUJiaVV6Y3poa1BNRFBHUGFYNkx1NVFlRHd0V0o2WkJHdkhhTWVReHpnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ky9wbHRVc004eWROcXJLcXhCN1FCb2J5N1RTOXFiNzY0dkxEcW5ERnkwSnpp?=
 =?utf-8?B?UUc3Z1RBWGdCN1p1Ymx3dForaU1KTG91ZkV4M2drTkNJUlpRK0ZGeVJjcUNW?=
 =?utf-8?B?aHdockZic054V1RzeW9hb2Q2U25TRUx5TG9TdHFIS1VuaHh1Q1VHL2ZhZVow?=
 =?utf-8?B?eGtEZENWT2ZiSHVaR0IvK0M5a1U1WEhERDB4ajl1S1FseGJ1RzBUZ1Z4MURW?=
 =?utf-8?B?UXRvSDZyWUtVVmJJcDl6Y2JsaUpjSU9pY2JCZTJVOUNyUnJtRlBYSWQzNGJh?=
 =?utf-8?B?TVErUlF3ZSttVCtadCtIZXhwUVJmWDQ0QjJqM3N0ZEpsUE41WGRhOXRzbzV1?=
 =?utf-8?B?N29IVGZOUDdQVFloT3F6MWs0ZG9pNEtGMy9nbU9OOEh4S2Z6eDZRZlRMK1hR?=
 =?utf-8?B?Y1NhZjZyNWhjOVJMSVVrZ3VCd0pyM2ZseG1oTDIyakZnK250bUhmTDI2NkEz?=
 =?utf-8?B?Qzk0SjZEUFFqSVB2RFRLWmkwaFdaT0doLzVPMnUwcHdIV0lUa2Q4cFVEOTlx?=
 =?utf-8?B?MUxkem1WeHdaVE5KbDZxVGZYK3p1ZzVIdWZsT0pzbXc3a3BoSkhQNmtMRklk?=
 =?utf-8?B?UXRmb3RqL2U4VXlPV2p2YkFCOTRoblErRjE4eDdiWmd3bW9MSm1XbzZWcGFr?=
 =?utf-8?B?YzZXenU3bzVDSm81bkc5Ylh6UzVkNCtGRmlUTFpzckJ2OFQza21kTFdaMnFI?=
 =?utf-8?B?WXNLRGtuSHpFTkg1eENsSmZjanVrS28vWVY2d01pdy9kRGE3OGdiNzdsbTJL?=
 =?utf-8?B?Vmlac2NUb0hWR2JFVWhxMFI4TTJ5MmFzUDlMbFlzd0dzMmJBWXBWcUN3WU5U?=
 =?utf-8?B?SkNqZWVySnhLeXE0MnQ0TkNVakd0bEc3ZzY3bVJVTUtrclZJd2xLUUl6dnpm?=
 =?utf-8?B?djA2b2VUZWxrNFFPYlFoRUQvL3lESk41c2RqT1owRjRINnJlQnpNVFNLVGNX?=
 =?utf-8?B?cU9TOUpiL1pKQ1ppUmFLYS9PckZvMCtPSVZHV3ZsY2VldXViWGxpc0lpMU1o?=
 =?utf-8?B?MU8vUklObktzSXJxUXhWN1V6Q2lYWGk3MWtxL3VGUXRNcko5NzNJclRoOHJn?=
 =?utf-8?B?ZVlsQmRBNDZLYXRtTkRlcmlDbDJ1dXVMcnY1dkpZcFZ5STd5RHNSUzlOM1pS?=
 =?utf-8?B?TXNtYzJ5ZUZKaWF3ZDV3WnRXUmowN1g2Qyt5cWVzY2ttV0tkV0lSYXJWbU5Y?=
 =?utf-8?B?Ny9UOTBPQmZPMm9NNHZPaTh0NENKQW8yYmhhVThnUFZMbnlNR1dHd1dRSmZp?=
 =?utf-8?B?K3JROEtRTE9wZVF2ZFZFZ3BFOFJTNjBCQ25MK2dzdGtPSWY2U0w1ZkhjamxS?=
 =?utf-8?B?L2l3OXZKSU93MkhFZ3dtOTVta2E5aGhzN0NkVHBuTDAwZDUyZ1o3RElzTy9p?=
 =?utf-8?B?TjZRWVhGVkJreGcycGJHWVNVSEltaXNzV2hrbHc4ajkwSVo2Mjlwd2F3cTZv?=
 =?utf-8?B?RmhENlgvSHJReXhPQm5udWU0czZBcUhoOXFzVmpab0dwNmxOeEhNYXRycTdy?=
 =?utf-8?B?Z2dCald1dTcxZEpYNnpvWGxzZitNU0cwWUMyRXo1cVdFZGhodmN5Tm9tZ0xu?=
 =?utf-8?B?VXZXMGp2ZmtUWWowL0dNZlViMHV3V0IzdDBrYXpTRU15bzBZR3ExeHl0Rldw?=
 =?utf-8?B?M01HT0lMeUNid0l4M01MQXVCanlXc2lJVmw5R3pyU0ZteUpmVFdCUzRvYnVh?=
 =?utf-8?B?cGhFb1QzbXgwMkkrSXRtWXN1Zk1YM05LTHdTRVhNSUV6OXpRUEd2WmNuVldt?=
 =?utf-8?B?RXR3cUJ1djRuVWRWenFVZ2hRNGR5c3VYM2xsdzl4OEs2UGtHTWVPNU01RE1Y?=
 =?utf-8?Q?DOOvU+EDf57QP7BXIG9JsLwf643PIT9AAQFOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d441d7-2790-4337-e6eb-08de6021662a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:02:49.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8603-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 458AFBCD23
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDMwLCAyMDI2IDg6MDQgQU0NCj4gDQo+IFF1ZXJ5
IHRoZSBoeXBlcnZpc29yIGZvciBpbnRlZ3JhdGVkIHNjaGVkdWxlciBzdXBwb3J0IGFuZCB1c2Ug
aXQgaWYNCj4gY29uZmlndXJlZC4NCj4gDQo+IE1pY3Jvc29mdCBIeXBlcnZpc29yIG9yaWdpbmFs
bHkgcHJvdmlkZWQgdHdvIHNjaGVkdWxlcnM6IHJvb3QgYW5kIGNvcmUuIFRoZQ0KPiByb290IHNj
aGVkdWxlciBhbGxvd3MgdGhlIHJvb3QgcGFydGl0aW9uIHRvIHNjaGVkdWxlIGd1ZXN0IHZDUFVz
IGFjcm9zcw0KPiBwaHlzaWNhbCBjb3Jlcywgc3VwcG9ydGluZyBib3RoIHRpbWUgc2xpY2luZyBh
bmQgQ1BVIGFmZmluaXR5IChlLmcuLCB2aWENCj4gY2dyb3VwcykuIEluIGNvbnRyYXN0LCB0aGUg
Y29yZSBzY2hlZHVsZXIgZGVsZWdhdGVzIHZDUFUtdG8tcGh5c2ljYWwtY29yZQ0KPiBzY2hlZHVs
aW5nIGVudGlyZWx5IHRvIHRoZSBoeXBlcnZpc29yLg0KPiANCj4gRGlyZWN0IHZpcnR1YWxpemF0
aW9uIGludHJvZHVjZXMgYSBuZXcgcHJpdmlsZWdlZCBndWVzdCBwYXJ0aXRpb24gdHlwZSAtIEwx
DQo+IFZpcnR1YWwgSG9zdCAoTDFWSCkg4oCUIHdoaWNoIGNhbiBjcmVhdGUgY2hpbGQgcGFydGl0
aW9ucyBmcm9tIGl0cyBvd24NCj4gcmVzb3VyY2VzLiBUaGVzZSBjaGlsZCBwYXJ0aXRpb25zIGFy
ZSBlZmZlY3RpdmVseSBzaWJsaW5ncywgc2NoZWR1bGVkIGJ5DQo+IHRoZSBoeXBlcnZpc29yJ3Mg
Y29yZSBzY2hlZHVsZXIuIFRoaXMgcHJldmVudHMgdGhlIEwxVkggcGFyZW50IGZyb20gc2V0dGlu
Zw0KPiBhZmZpbml0eSBvciB0aW1lIHNsaWNpbmcgZm9yIGl0cyBvd24gcHJvY2Vzc2VzIG9yIGd1
ZXN0IFZQcy4gV2hpbGUgY2dyb3VwcywNCj4gQ0ZTLCBhbmQgY3B1c2V0IGNvbnRyb2xsZXJzIGNh
biBzdGlsbCBiZSB1c2VkLCB0aGVpciBlZmZlY3RpdmVuZXNzIGlzDQo+IHVucHJlZGljdGFibGUs
IGFzIHRoZSBjb3JlIHNjaGVkdWxlciBzd2FwcyB2Q1BVcyBhY2NvcmRpbmcgdG8gaXRzIG93biBs
b2dpYw0KPiAodHlwaWNhbGx5IHJvdW5kLXJvYmluIGFjcm9zcyBhbGwgYWxsb2NhdGVkIHBoeXNp
Y2FsIENQVXMpLiBBcyBhIHJlc3VsdCwNCj4gdGhlIHN5c3RlbSBtYXkgYXBwZWFyIHRvICJzdGVh
bCIgdGltZSBmcm9tIHRoZSBMMVZIIGFuZCBpdHMgY2hpbGRyZW4uDQo+IA0KPiBUbyBhZGRyZXNz
IHRoaXMsIE1pY3Jvc29mdCBIeXBlcnZpc29yIGludHJvZHVjZXMgdGhlIGludGVncmF0ZWQgc2No
ZWR1bGVyLg0KPiBUaGlzIGFsbG93cyBhbiBMMVZIIHBhcnRpdGlvbiB0byBzY2hlZHVsZSBpdHMg
b3duIHZDUFVzIGFuZCB0aG9zZSBvZiBpdHMNCj4gZ3Vlc3RzIGFjcm9zcyBpdHMgInBoeXNpY2Fs
IiBjb3JlcywgZWZmZWN0aXZlbHkgZW11bGF0aW5nIHJvb3Qgc2NoZWR1bGVyDQo+IGJlaGF2aW9y
IHdpdGhpbiB0aGUgTDFWSCwgd2hpbGUgcmV0YWluaW5nIGNvcmUgc2NoZWR1bGVyIGJlaGF2aW9y
IGZvciB0aGUNCj4gcmVzdCBvZiB0aGUgc3lzdGVtLg0KPiANCj4gVGhlIGludGVncmF0ZWQgc2No
ZWR1bGVyIGlzIGNvbnRyb2xsZWQgYnkgdGhlIHJvb3QgcGFydGl0aW9uIGFuZCBnYXRlZCBieQ0K
PiB0aGUgdm1tX2VuYWJsZV9pbnRlZ3JhdGVkX3NjaGVkdWxlciBjYXBhYmlsaXR5IGJpdC4gSWYg
c2V0LCB0aGUgaHlwZXJ2aXNvcg0KPiBzdXBwb3J0cyB0aGUgaW50ZWdyYXRlZCBzY2hlZHVsZXIu
IFRoZSBMMVZIIHBhcnRpdGlvbiBtdXN0IHRoZW4gY2hlY2sgaWYgaXQNCj4gaXMgZW5hYmxlZCBi
eSBxdWVyeWluZyB0aGUgY29ycmVzcG9uZGluZyBleHRlbmRlZCBwYXJ0aXRpb24gcHJvcGVydHku
IElmDQo+IHRoaXMgcHJvcGVydHkgaXMgdHJ1ZSwgdGhlIEwxVkggcGFydGl0aW9uIG11c3QgdXNl
IHRoZSByb290IHNjaGVkdWxlcg0KPiBsb2dpYzsgb3RoZXJ3aXNlLCBpdCBtdXN0IHVzZSB0aGUg
Y29yZSBzY2hlZHVsZXIuIFRoaXMgcmVxdWlyZW1lbnQgbWFrZXMNCj4gcmVhZGluZyBWTU0gY2Fw
YWJpbGl0aWVzIGluIEwxVkggcGFydGl0aW9uIGEgcmVxdWlyZW1lbnQgdG9vLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5kcmVlYSBQaW50aWxpZSA8YW5waW50aWxAbWljcm9zb2Z0LmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgu
bWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgfCAg
IDg1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1
ZGUvaHlwZXJ2L2h2aGRrX21pbmkuaCB8ICAgIDcgKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1
OSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwg
S2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg==

