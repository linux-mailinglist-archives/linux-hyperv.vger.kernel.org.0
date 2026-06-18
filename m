Return-Path: <linux-hyperv+bounces-11637-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4b8DBUvNGqEQwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11637-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D96A1FF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=MvlvIM5I;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11637-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11637-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818A730398B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797632B134;
	Thu, 18 Jun 2026 17:46:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010029.outbound.protection.outlook.com [52.103.23.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E4175A89;
	Thu, 18 Jun 2026 17:45:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804760; cv=fail; b=IsbDJgeY2DguNnc9dEfCMXK5wo33UdSLboa8s/HLLzkKWAbJAx5V/F13eVGMoYyd3VaWOHaPlcO6LvTJErA3FJJJ8pgAv4brLQ74dAmk9ezArWs7kNJKQ7ye+zVXEhXNvNFOphLc8rfQM0PbDX4m1pDDuMOv8UTmrmnw0osk3RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804760; c=relaxed/simple;
	bh=2F33lA3LAn5RVyKBlBET5oFLPPe4kIr8m87g3cC0PZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+dmmIuWJYtWtBXI9y5mufBVM2Oh8ODe4nrr0yObM/C/9N8MnhLPoLURvMnoszPLRwTakvr/4YixtxC6YNoUgVcQ4eBrfrf5qYnc3B957wWHse9O0LFe11XR556Xr/ymdrSoCKpnNLoGMCyPoTdMqWQY4mJQQh3/vWAVZv+b9gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MvlvIM5I; arc=fail smtp.client-ip=52.103.23.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO4dihVpRbmRCkf1S2QKz3fFSEZcwMUfUCDz8RqxoIYaXCeqPnLadwzeId7NKph7n2761JPF7IlM7WsJnuIhtx9HQpVFyhlGyyROwODRxPMrE/jtq548KZDNkGzn7XvkRlAS1dmIjP7b47nKRXWZ+K/VKtia8f+1BbFndUiMLikZ7TXw845rB1RXle5PtpLhadeChliZwAl8nR3Ybsy8H2ghJq+k9zBqvoG9V0C5tbRHSMI77Bx/j6jWUYBLV1Lm7vULSIuPXJZZMm1olb4wrqMLJ8jhLUW/CGdtk/eMuMUiiCWwHscOko0v1KmHfUYN88v6TIZ7wN/LnalT2hmuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2XnKdxRnnEESk2c2F6kRWskS7Gll+3n5YXYMHMaImY=;
 b=vu9dMg7qmPG2IPGc8hFe7T+gO88iSZXFRIL8GvpQS7qhzv+IxDDcXTmJggF8lnG2z2KV3Hyx8OM9maSI7y4S5QIdVfLg0CTggSQZdf7fWGsvunG6WPtz4hV5REc+nSbJ2PoixsBBZj1kN64lZX3NxdTwNEOM+sAyqd0QhQikFusrHst2flyYruh4q4N1qtnXCFccFBd/iTR6AMb9ixnTepucjwOJBuV5np/o9bgt7HJyCw9vBPUkYUSAipt8ADpYZcNUsJF8r0IirUhEEscPam1LSQloaj/fdk6dpRtQ4j42m+gCzSXV2aWeDxj5EhFSoWgDYhWtGcXLKhX41aIQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2XnKdxRnnEESk2c2F6kRWskS7Gll+3n5YXYMHMaImY=;
 b=MvlvIM5IV51AZ0U0j8zeqjyedC0c8X1NPGgsV8gxuOeh4ZeqtyzgJ5tERQxajtpXqqh6K84AWqYVc3uz4atEhLwPxthDeh/17OgAaIt/88Rh9rMkpjm9Kfc2PivP0H3BlxoFDKG1k6F6lB96kaGf2x74xBW+rMmVLTegqlZto1KnmHf4n+5mz2T6V7dl5h1tNvYQ8P8mN7+lON1D7DZ3gxt7FsL7GhEHvWGx5RLJJUamrCQ5z7hRHoK+O+102HkPxNQdGJ+h0p+VNmhR7OBtgpiQXRnRvYOeM8Spt4fqGyr8CYbQGn3pYE+Emv9vcY46dXJGhJBaXWv5Qy5iiq5T2g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10791.namprd02.prod.outlook.com (2603:10b6:806:440::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 17:45:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:45:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Thread-Topic: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Thread-Index: AQHc+DtPxcOOrB/q7kidEc5w+N6QuLZEpCqg
Date: Thu, 18 Jun 2026 17:45:57 +0000
Message-ID:
 <SN6PR02MB4157F6A66DEDE650298E120ED4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
 <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10791:EE_
x-ms-office365-filtering-correlation-id: 394ad267-7560-4f4b-3c5a-08decd617411
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOI05fU2m3MB4pFFz6pPmbb0zEddZgDDKwjvcqYZRZNGbSypSO73FYxB+dMJ1aRUbSZb8RFEzGh/Gy6WdTZrHUJbY48arzS286NbbuBYz9YF4IkulGJOpYxgXHvGq/MoWSR1xnFxHWlgbspRC/c6KeyRD5WB2AWdYBG33pR7hvjnktt2rHxEN6TLs8wi89VJFlb4HSmRMaLvJLKQ9gB6YHchSD5dcu8NbSb2hzLrA10tjW2le+/5nPLe27Cbek902dZ+ZeI4Tl1boV6Y0fF5lqT19Tdtpgz2FNNyD039ex20ONczMr3wVAPND9PwXOXb7+ZCQpK0RdkP4pqgHQNUvu3O8sYsNNielVzB1YZUotVMGInYL4gUC+AjQsvAnvu9Kmrah6dJsKEvVZqRSUME7XtdKm+wbqUlE20FZvP8MxZqPFFev8yzR0TCLRCDwJQZRJlyWiwmlkNcP8d0lXBQtTPfdjVXX/ZhRBLxks0y4oQV0Ptph852mKJGxXcUPTOzbDCVUGJ7XYRxGRe+rcjMakNa0FFV4CThOW21DlDzFDxv/WnlVX1Nz1EQzAMq2aP0FcSFmnRP3Oz7d3WCjY7rvTqr4Pf4bgW/BDQrNaMlj6+kQ+jtbAAVrQi5rumF/bqoZlj64vJsz4LIBwQxdKPSefUX5Gn+zeJICLAMYemMzxeI4FgDCjTcrPCf+9HyR6K0xXWQZNj00IaF1tuhLnVJgmgnG/T/cSaASY4ToLQqLDs6Q=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|31061999003|12121999013|8060799015|8062599012|15080799012|19110799012|19101099003|13091999003|51005399006|102099032|40105399003|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tCiUB1SMlddP15xi87REezpTodJj9pLxKi83LAoMEROusEcjxTIBjJte5QVd?=
 =?us-ascii?Q?cTK0h8EqXYoibw4/xc3I0ZSrak9k8sUscREPMAzYrYElQhPjxUA/vooELLxS?=
 =?us-ascii?Q?mUvB6gnzFiJYKgiHZ6vQ5GINAaSyFPny9kJmuQSfadf/3IMWDBI48IrJIoA6?=
 =?us-ascii?Q?y4Pa3qtXITrxXP3hV24o0/AS/AoARDjq9xqkX/cwCte2CTPNbd3hNzG8Dt1f?=
 =?us-ascii?Q?NHSukyrHJxFIGX1noTwL8g3nVFe8Ps2dz86eoUGgPl03S3aBgn5fPW7KGakT?=
 =?us-ascii?Q?Y7JCwI2sOvXOZZKsp8ZEOrJBir1DGQ3id7zg8YsqzB7dh4vr973MjGBP5GuJ?=
 =?us-ascii?Q?jVb90MiEF8kdGFjiwp9nqIIoW4/dCcg/s8ynYb99hep4EdUglX3Vphwd1kwu?=
 =?us-ascii?Q?lLa/QHqUnY/j/VAt1EfPtKZLSFVA1JJQi0AIiBslJsoiEnpwVrP7Y0s/X8oJ?=
 =?us-ascii?Q?Lpn4x+JeTSESralEvAKfoEs3Ng6dESAQ262jPbOc0Rz7OslrCxNBcxKTnhBI?=
 =?us-ascii?Q?T6I72Z9bJnuBrO7dy/vT6/lv7tp9gh/Wrs2A2lHBn8aBAb2jhkV0ZBKd4man?=
 =?us-ascii?Q?hV1PQLjHmZ4n20/aQ2W+SqZcez4xXolLyK9WBE6PTg601IoM62hEDBrQK+Fn?=
 =?us-ascii?Q?AF0iq4rdir9y9MBjiaP1ZvFe4dCLTSKODs2B2NK2+7vKQpLSuLs3W4+2ew1g?=
 =?us-ascii?Q?BHH55T5JA+hMtqzvxpTdmN1a+95P2UK+mH/Jp6YgD8+VDFD9Ioo7yL8KVNaQ?=
 =?us-ascii?Q?WucXTEu8R5w7StJPcgNR26AiLLeMVAx4mE3nj9XDA51dB6GsT/r94BMOmT3Q?=
 =?us-ascii?Q?1NSCsrtuRC2vMItk/1q8SpZUWUYzFirSVNTEzV8AQDB3tuH20jRban0MAikV?=
 =?us-ascii?Q?6e39zg4R/0mdn3VkuDuu2W89ZpUpAF59+WNbof2DBak/17A60Vz6q+FecpFS?=
 =?us-ascii?Q?vklETHaTXNWo9NEyLo4vLGZerT/HIoyTVD8hyKJuuo56EPcUDvO115oYQmrF?=
 =?us-ascii?Q?AnxMX36hmtIPZomx+q82nK9wSajjmi/iRwl8lrlDaY0gTlTOKYLO18jqp92e?=
 =?us-ascii?Q?d73rP4E5omCQAHnNo5ANELLHLX2XcA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OCHPnt0eefrMD71Fv5wMeb/Zq78u1fW9v23JHHdFm2my26I7gZdRuMKWEY8v?=
 =?us-ascii?Q?6qQHfcRa6kNXjXDaygsL4xAhZA5u21sw4X2m5tmCHE5RSjF8Gkdd32zJQs9o?=
 =?us-ascii?Q?2tuPIwvHInjXb4dAK3K1rvrMmNy2qSJoejMHRj6zA0qMZ0sL5Yr0P1W8lpBs?=
 =?us-ascii?Q?vUFzIsEimnnsKBmYwlQsIKv9FhBtR1+e4Kt8Z5fVqu4b3ov8RPDsi0OB8IqW?=
 =?us-ascii?Q?5P9hZ3PleUMcUyfPwQIQWjZbhwzeF1vyOKZfPN/D3g3zS7D1drQgoCRSJ4HJ?=
 =?us-ascii?Q?mXWMQoZEAa8Tjsm/rsGGhRctyVHemmWcRR4lQ0zvWqUfcBZa3MkS0J6nvgQM?=
 =?us-ascii?Q?InYiI2PAxMF07MbUmLmeAazjMeKFZcK9b+4yv4ah/x5ZsuupQKoYBfaBKhz6?=
 =?us-ascii?Q?nf4KcLxIrB8PjQmqk2d5dgplMK+JIALf2SOAek3JmVj/NNuuExAY45oc9TnC?=
 =?us-ascii?Q?oMywbJP3YxEkDQXqRtKvAtgnskq2d4+4bv4sNoVZJgCrSRoH/7FEyVtLYFXH?=
 =?us-ascii?Q?2p/KCFFYyter2WkcqE4kwHqL4g9B7H8BevjeGxxhea7HRCoSKNTDJc3RRtjB?=
 =?us-ascii?Q?p/C+B9iuLiMKZkbt68bGxxOJn756GTIgeZNBQB39Or9KW1rFqvoV6lmgAoPp?=
 =?us-ascii?Q?U/HkTNYfMGfVtEAPM/RW0bNWzRxL3cyYXRvBYGvaYcfjZQV3rjer55h2mulr?=
 =?us-ascii?Q?Xm7YB8aFPJVfljgDXBLJ2e9lf5XaWRf56T39mYPQGGKUz+s8g1n4mA3Ycz6l?=
 =?us-ascii?Q?4eQ0roBOS8iRxOsND4HqSb98C2unuFyO9ukfQv33wKYJRfiaW0r9tyHV5EVu?=
 =?us-ascii?Q?K+hkqErXwOaA4x2XBwSin0VT88H2RIZduN5grAb2Gwg59COOPgltciKNUIAu?=
 =?us-ascii?Q?HRXVwQkgNwwhaHislRepnCoTBtexWG8/yWPGdtLtm3gNHf7FMRuYmhAYIJOS?=
 =?us-ascii?Q?ykmKCS/eJTRAimoJVOa1cOsgH6TRbeiM0VGbrBDrd7i2TvpNbtZx1DxLz4wl?=
 =?us-ascii?Q?AVAjvcw33s4gfG73feLTNYE3BR3rSI/P7HD2XNJN1nSPc6ZkVT/Q/U1QENke?=
 =?us-ascii?Q?E5EUKDnK4FJhMzTC/qCPte/J9UTkG9IO0bmeRxUJozwzod9rv2HhZaXHkjdt?=
 =?us-ascii?Q?G35XX7X2viT3r+p4EgRrC7e6ncgKe90nU5NkV9sG7KLbfpWukHfprpfHOLee?=
 =?us-ascii?Q?GeAVHcy8yWkQYGpBW5ScQtgN5ONtPWBvKASnI7WcW5X/+H7LDix5Xc3h1XfM?=
 =?us-ascii?Q?meWhB+QI8rRoic4qfd8auZVPAcL0nmR388AnYT0VK4hBqzYd90GYsD2eImN/?=
 =?us-ascii?Q?9vZNAHJQ93WW3A+mnHHulM36ZGeyJ4pWOMP2PLReAfUkuX2G5sGZWtNbOeOh?=
 =?us-ascii?Q?nBD2if8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 394ad267-7560-4f4b-3c5a-08decd617411
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 17:45:57.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10791
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11637-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC4D96A1FF6

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June 9,=
 2026 11:10 AM
>=20
> Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and
> use rsi_host_call() to query the hypervisor vendor UUID when inside a
> Realm. The realm path is factored into a helper,
> arm_smccc_realm_get_hypervisor_uuid(), that owns a file-static
> rsi_host_call buffer (uuid_hc) serialized by a spinlock.
>=20
> The RSI-specific includes, file-static state and helper are guarded
> with CONFIG_ARM64 because <asm/rsi.h> does not exist on 32-bit ARM.
>=20
> For non-Realm environments, the existing arm_smccc_1_1_invoke() path
> is unchanged.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  drivers/firmware/smccc/smccc.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index bdee057db2fd3..6b465e65472b0 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -12,6 +12,12 @@
>  #include <linux/platform_device.h>
>  #include <asm/archrandom.h>
>=20
> +#ifdef CONFIG_ARM64
> +#include <linux/cleanup.h>
> +#include <linux/spinlock.h>
> +#include <asm/rsi.h>
> +#endif
> +
>  static u32 smccc_version =3D ARM_SMCCC_VERSION_1_0;
>  static enum arm_smccc_conduit smccc_conduit =3D SMCCC_CONDUIT_NONE;
>=20
> @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>=20
> +#ifdef CONFIG_ARM64
> +static struct rsi_host_call uuid_hc;
> +static DEFINE_SPINLOCK(uuid_hc_lock);

So evidently Sashiko is wrong in saying that struct rsi_host_call must be
in decrypted memory?

>=20
> +/*
> + * Helper function to get the hypervisor UUID via an RsiHostCall.
> + */
> +static bool arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *re=
s)
> +{
> +	guard(spinlock_irqsave)(&uuid_hc_lock);
> +
> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> +	uuid_hc.gprs[0] =3D ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> +
> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) !=3D RSI_SUCCESS)
> +		return false;

Rather than having this function return a boolean upon failure,
couldn't it just set res->a0 to SMCCC_RET_NOT_SUPPORTED like
arm_smcc_1_1_invoke()? Then arm_smccc_hypervisor_has_uuid()
could process both paths exactly the same way.

> +
> +	res->a0 =3D uuid_hc.gprs[0];
> +	res->a1 =3D uuid_hc.gprs[1];
> +	res->a2 =3D uuid_hc.gprs[2];
> +	res->a3 =3D uuid_hc.gprs[3];
> +	return true;
> +}
> +#endif
> +
>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  {
>  	struct arm_smccc_res res =3D {};
>  	uuid_t uuid;
>=20
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +#ifdef CONFIG_ARM64
> +	if (is_realm_world()) {
> +		if (!arm_smccc_realm_get_hypervisor_uuid(&res))
> +			return false;
> +	} else
> +#endif
> +
> 	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> +				     &res);
> +
>  	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
>  		return false;
>=20
> --
> 2.45.4
>=20


