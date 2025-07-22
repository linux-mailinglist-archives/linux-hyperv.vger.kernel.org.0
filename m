Return-Path: <linux-hyperv+bounces-6325-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF5EB0E173
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8290563364
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24722CBE6;
	Tue, 22 Jul 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A3Tb6X/J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020138.outbound.protection.outlook.com [52.101.56.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF868836;
	Tue, 22 Jul 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200950; cv=fail; b=EljTgvcAWRyHLFQO70/hsCEtPT3sGrcVHdrvAH57iEPFJGtD6kdovpgoCLLs0hMQBaGLELR22GwN73KV5PFHFdXhKSbZzVyr+kgegTqIy2WG6l6Z8/90Ys5lDs93lZahQ140v6Sy/OMcYABUuXlCWkhD27t8aLDnC3c3rlpNX8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200950; c=relaxed/simple;
	bh=0+ETi6vsFbOYcp58XdvQ34lXRXRPlN+iZnzRTRfgldQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iz8CQaWVOA0H9g+F8BecjLoFlCA9aWbjcbBZxaoevWBVdSaBgKqWT2oOhBe3HMRGU1TnNjQidNXW/GUFwdJTDQ3nkcnM73j3isApmNpMaYlx/XsJYuh52CSsUEEySDlCBU89iZWN70Er2hy4BX2Iwq2+F0uUq8Zoo+zI21GPgzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A3Tb6X/J; arc=fail smtp.client-ip=52.101.56.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwIbK7KLpwBqFCmJ1Ym2t0z50OJOtab0I8ql4XBONOt+zz7O1j0E7olMuHWbOcY/8QrsfDyKAuQLlwA7DW/CZO/HeorE4CvqVLsY9/AbO3ZJ1x17VvfkXMgymiYyR3LI7offez5uakLqr7qonW4wbgdGoG9K/w+fvkm3e07p0Uz59UbA9srwEvBEdjsUcJbDZtxPrgJswmVJ3gQnEqSlTByCajetCkeowJLb/ySp0pF+vtHEhXs5ZMlN80Ya6kZLYxYfPiOE9qtDauVjlGZmpdTPNm0EkStcJwCWVwx1TkTCC9566ffV0ooQck2/szS/CgHnbSO/FDO3hJieCLlk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+ETi6vsFbOYcp58XdvQ34lXRXRPlN+iZnzRTRfgldQ=;
 b=b/UEwyOlig90nP+9oOWenydy9Qi9XKoU+XGCYHJick+SQDF917ZWWm57lIgiP8GSrb5aq7gmF8WpsWsOZWItLlWb/QE1Se/oRwZMlxOKShH4FkhcsR9kplaXNpgIMWjlvr8M19lnbvddkIb4ibvaWJzxR0tE9V8AJ/rcy8pkTqpLZJPFRvNNui0WIXnc8M3teRnrIVWDCY7d/1GXZZk3hvVhv0nXC66/Z6XJF8hYOe97AX+YLyDhtC/LcHrC+N9hTgdckOtqWCA4Jjd261/8GlpHpA60lR3zF7m7J5eFet8EgCR6k4YGXitHScW8veBc8QjM9p/dWFnOpgXPOUqlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+ETi6vsFbOYcp58XdvQ34lXRXRPlN+iZnzRTRfgldQ=;
 b=A3Tb6X/Js9kMMUCtYO5LyxRy4iO3BiWDWthvEVBqAgtcA/pHXhPU9YV1NT6xW0zXhGVaQQtLRfGR3y5GxB0ZJ4EerzsJZvgmoEFWeCcyndpyv1IW+W19l8eVUaC1RC/jbUFVYsIVcIdUt2BS9w9CEsHuqbaUJ0mh5P9C5sqT/XM=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ0PR21MB2055.namprd21.prod.outlook.com (2603:10b6:a03:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.18; Tue, 22 Jul
 2025 16:15:43 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Tue, 22 Jul 2025
 16:15:43 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Eric Dumazet <edumazet@google.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"kuniyu@google.com" <kuniyu@google.com>, "ahmed.zaki@intel.com"
	<ahmed.zaki@intel.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "#@linux.microsoft.com" <#@linux.microsoft.com>,
	"5.4+@linux.microsoft.com" <5.4+@linux.microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: core: Fix the loop in
 default_device_exit_net()
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: core: Fix the loop in
 default_device_exit_net()
Thread-Index: AQHb+CF8hOfRUrm9+kmaxTYS2+tsGbQ9ufGAgACc8aA=
Date: Tue, 22 Jul 2025 16:15:43 +0000
Message-ID:
 <SJ2PR21MB401368342203BE4EFF0C6494CA5CA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
 <CANn89iJLnprFvLpRpJ7_br5EiyCF0xqcMM7seUVQNAfroc4Taw@mail.gmail.com>
In-Reply-To:
 <CANn89iJLnprFvLpRpJ7_br5EiyCF0xqcMM7seUVQNAfroc4Taw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c9f0666-7477-482a-a06a-d6235bc06977;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-22T16:13:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ0PR21MB2055:EE_
x-ms-office365-filtering-correlation-id: 13d440a3-2671-4d3f-be32-08ddc93b0250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnZYbTIrUDdOYzlkdEI5dXd6bmF2TUtMRG5ubzJoNGpBaUxLdFUvMkNGYjVP?=
 =?utf-8?B?VWxSUVBTTUlmcS9lTlpPQmFzVUtpK3ZFcmJaWmtla1JDYTAwcUNTNkpIR0xP?=
 =?utf-8?B?WEFrTFU1Rmx5Q3JiY1VjRzl1Nlh1Q3lHcVZWM01UTTNlLys1bUVxTDhsMnky?=
 =?utf-8?B?R1F5WmxKbmIrbEZ3aUltbjFlNG1YWGlsODVvRDVjN0FXaFZlWmlrZlBjWUF4?=
 =?utf-8?B?UXBCV3hnem9oRGJyS3BpdlQ3Qm1zcDE4cTNHelFRdGdhOXJBQVIvZ08xVjI2?=
 =?utf-8?B?QWdGOXdONVVaV2xWQ2N3SzBmeGViS0VHMTB0OUJUK2NXcVgxRkN2a1BQUGE4?=
 =?utf-8?B?K3VnMW9XVlhuRkpWQitONVpQbEFUSHRDWVpyQXNScFFyMWs0UWhSSnplU2tL?=
 =?utf-8?B?V3B5TVUxZzFCWjRFYmVRRXA0QS9tckkrNFM4MVQ3RzZBYVFKZENOYzhiaHBK?=
 =?utf-8?B?N0xHOHk3Z1Y1NVl1U01CQ1RzQTM1TnlIOWNaTHF6anVUd1NrT0c5RitQbi9v?=
 =?utf-8?B?a0h4RlJTeWxTSDdON041dXBmdXBrSTd3SXh0OTk3ckM4ZVZ3bURid1ovV0NR?=
 =?utf-8?B?b3p4Nzl1eWZIdUtIWUFqb05wMGVLQU5qaFdORUJSRzNCcWNyTktYVVB3NzVW?=
 =?utf-8?B?akR5R3psdndjU3JFT3hPTXVCbSsyUUZHM3FpUEhJWTRsMVBmS1RFaWcwbkZO?=
 =?utf-8?B?dXlDdjZERm52UFVyZ283ZXZ0elRTMjBRZG82VEw2a2pnNm9QeCs3OEYvV2cw?=
 =?utf-8?B?UHg3bWtnR2pLbitUMmFaZk5NcUppOGhFd3hBSlIwM1U1cERsSGlpa3FiZkEx?=
 =?utf-8?B?aWpxTXBYaFhGeVhtQ05qalFmbmgremFNM1F0cDlmR0dEUC9QcmsvVEs4akN6?=
 =?utf-8?B?UXVZeitKdXBOZnhIaHJMbWk5eGtENG9UamtlMmFMeFAxZ2QweHlsRk1RSFJp?=
 =?utf-8?B?b0NtZE05YWd2Tzk1NHZJc3hWTTd1U2MvYVFLdEtja3BiRlA0NUZIRFBqSGxa?=
 =?utf-8?B?bXpWdG5EbWd4OCtPYXdjUW1nM0laTnhZOVVCS3gyS3VMSW50WkJpVGtkZDNF?=
 =?utf-8?B?RDdaUHNuTjJWbngwaU9DOG85WndKeDdBeXR4YkFsTXFIL0ZHQnRKNmtrbjJH?=
 =?utf-8?B?YmMxUnYwb012SGw1c0k4ZVVlSXI5OXNFanJ0em5PVHpHTlFaS1NsUVhMck9U?=
 =?utf-8?B?SGhCZnNJNHZLVUVtaC9Za3VGTGRyZzZiM3AxaFRtdmQrNlZ2RTdleEg2ZXVj?=
 =?utf-8?B?TG4welJNcFpZUlZIK2V4TzdEYTRuYTljaFNoV3ErS0hDRjR0cXZrNTF3d3h4?=
 =?utf-8?B?Z3R2MUhDVU1Zdmp2WVZxZ0UxaGpTOFBWQkpReU43TGlPbzZtVlBBZUxucVNv?=
 =?utf-8?B?Rk9kOFpmcVVMendWdmk5eDZ6UFFwbm8rYXBwc1EyUkJSakFmWXVWV1l6R0J0?=
 =?utf-8?B?WUF3ZmhNNGl2UzZqNnFkN210bkw4c1l6THZZVGVmMW8vZEJ5Sm5WZTFVL3BQ?=
 =?utf-8?B?SGVzd0xOU2oxK0xXUm9aUGJTQng0c0V4eDlkMVlvejBKSnd0L2lEZm5wRVpz?=
 =?utf-8?B?MEZ4VXVvTUZXWktGeXBIdDhMVVdoTGw3NDFkU2FuV05WekpFWDRVUVUycXp0?=
 =?utf-8?B?MEZrOHpqN2U1aXc4amkzbnhFL2lac3liN2hWUGF4T1d3NVNVeGJ6MFJHSk52?=
 =?utf-8?B?M0JjNGV6cGEwY2VnaS9mUk02bTgvWDdYU3NtMWw4TEFwcnd5T2diVHI3SC9F?=
 =?utf-8?B?bkF3ODN0cnNtQnhHQlFnNWp2a3ZxRHMrSG40RjhYQUZ3dnZicWE4NU5iK0tY?=
 =?utf-8?B?MGFrVkJNb0dxd2o0UFRhL2duTDNDV0tidjVOa045alYwT0NaQVVQaS9GSzVi?=
 =?utf-8?B?WHhxb3pKZi9zS2UwdEJNZE1ldzhlRmIrQ1ZtVHN5Y1V0ODlFUXp1eGdtbUxo?=
 =?utf-8?B?RFI3RmlIWWRBYWcxTzVMZm1iYTNUNG9MOS81Q25INFNqQllENW52cVNqN2pJ?=
 =?utf-8?B?bWNtNDUzN09RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTlLRWxYRjI5dE95aDROQzM0M1dDeHNnSFZBaVZzdkp6Y1BkTUJYSzUxUTBY?=
 =?utf-8?B?emk2RENNL0ZGVW4rREkxZEJFTkNVamdRZG1kMmRHTklLdWl0YzNJZWhnVFZB?=
 =?utf-8?B?U2ExSEYxUVRDRHNVM01PRE90S0lKMnNoemlxQTkzVjlQR2poVnF1RkcxNndz?=
 =?utf-8?B?TU5rWjQrZVUwVWdOcmdjdmlRa09hbVIvaHZvZ2hMTWlFUm1vWVp1K2VVSlhW?=
 =?utf-8?B?dmpOZkxKM1JFcWxFVkQ4a0xzK3hROHp2OWJzNmlrcFVSZmVNYS9HOHJJZnVQ?=
 =?utf-8?B?RkljTGZmWlp2djV6d2NQWTZ2NktNUUhGNE9BSnpQN2lHcjhjQXJORXRrL3FE?=
 =?utf-8?B?TDlhR2MvUXJOaE5pUUU1U0RvRXhITC9CaGlhRnZaeGRxQmxvVFFZRk5SODNX?=
 =?utf-8?B?dTR1empabU5qWUVLMWRmNzRTL1RoRHB3SENZb1NXRncxRlU2VDlEQVBZdDJI?=
 =?utf-8?B?Y2wzN2pJV1J5U0FwNmI2a05vSTdWZWthbENLK09GREdFV0cyTlltVFBjeWVF?=
 =?utf-8?B?WksxUG5BQm9rQ1NHcDZBQ0JXazRLMEU0ZDM1VzVweFJKS3h4OWk2T3BmT2d3?=
 =?utf-8?B?c2VlNGREaVUzaytNYkRFSDlNRFpaOEJqMURnNENSYXBqMTMvZXU0WmZISVM5?=
 =?utf-8?B?cHVLVUpEQzJMa3R0cUJiWEZqNjFuMG0ySjNsb2x4Y2xaZlo5cUdVQWdabWNF?=
 =?utf-8?B?eHRXbWVlSFBYODFpeUQxa253MkJYaTZweVdYaFNIemVBNTJkcDl0UGJ0YVJu?=
 =?utf-8?B?ekcxRkMyVkNUaFplaWZtb0xTMXFIQXZYOUE4WUdmUzJaZFE5Ri9lVmFPWkln?=
 =?utf-8?B?cDd6NEkvZXQxYkRHaHZ3NTd6enBNY3RkanQvT3luZHFlbU8xaDM1Y1dNUEJC?=
 =?utf-8?B?K04yWll5eTRoZ213R0tMLzRhcHkrdEt3aXMwRTVvYTQ1WVpHc09YVHowNk5w?=
 =?utf-8?B?M1FaSHhHekVicmZwV1NjR25PMHZSZDkzYzlKaHYzZDBjclArcWM4amgxSm5u?=
 =?utf-8?B?WjhJcmdNKy9LSDZxTUF6NzB1UU55UUc4MnFQK0tWejV3emxmSDdza3JUd3lw?=
 =?utf-8?B?b01VOWs1OXNDdzVVaHZJUTRGSFhXNmhRY1BDU1lINlg0anI2bS9STVV3M2Ir?=
 =?utf-8?B?Z0RHOGhFNGtYa0R1dE5xRTV4NmMvSjVzOEI4c1BsNXpqWC9mTVE4eUdrT3Yr?=
 =?utf-8?B?a2c3emJ5NlUrdTd4VXdkZ1gvZ0EvM2h2L0xndU03ZkxJejRNR0Y5ZTRSNVI5?=
 =?utf-8?B?VFJlcVhLUFJMVHE4SjZCakZRY251UlV6YXpJM0taaWVERE44UVFUaVVXQ0pL?=
 =?utf-8?B?elhaY2doUFczTjgxL0xYeVp2OWxXK1JlM2ltSnNGM1FXQ3UvL21NU2REL0xF?=
 =?utf-8?B?Qy94TVdQRW5RS0tLZGtaNHl5bVNZaC8wK05scUNtTlFXUjYzSjNuUURNZ3gz?=
 =?utf-8?B?TE9kWm9FbllDRE5tNFdldUpMYzByU2E2NzRyd3ZvbE1lZW1vL1dNSzAwQWxs?=
 =?utf-8?B?bjVPdExMc2lCYnZtQWNYNkY5dmdLTkw3djRTODgrMlhqaFJLUXNVR0pPQ0pB?=
 =?utf-8?B?SXR4Z1lPZlVHVTBZc0l5eHBUTWpxckIrbFZYOUVsSzAzc0RFV0IrTEdHUHhz?=
 =?utf-8?B?c1ErOGY3NWY4R0pFam1rOUpRQStKTm1DRDlFcnBGZ01ZQlZuMjBkRXpnTjI0?=
 =?utf-8?B?TW9CbUE2bCs0bjVGZDZmem5QK21xRE5XbHFWSnFkK1dFNEVLMVBFVURuVmNQ?=
 =?utf-8?B?RXRUSUtsSzhzaFE5QU5zRTArZDVDNkhOc1Y3MVYxMXVZWnd6bS9DQ2ZJNXE2?=
 =?utf-8?B?Y2xlb3A5OTl3QVNGYVhLVmlIRHRMRjN1NG0wM3R5UldFZzZUNnpjWjJqK2FX?=
 =?utf-8?B?TjNXdlZxaUZOcm1tVzdBQ2l0cTAyT00zTFdobzhUdHBJM2dJUDJFUWVhbldB?=
 =?utf-8?B?TnZyL1Z4SC91ZlBCYXVEWFhsbmZwM1doNEkvdllaOHBkNGxJWG8xNU51NWRC?=
 =?utf-8?B?SU5ic3hCY3NUbEFJOGtqSVlpYmdheUgyZUxTNEZEU2RGTzVVMDBISFhUbENU?=
 =?utf-8?B?YWQwOW1FYWxYNis3RER1K0IzRlVMT25IVkZoT1J5RHZNblRqS3FYbUg2ME1m?=
 =?utf-8?Q?c0jwRTPcXBOQHAmEB3vWoH8Me?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d440a3-2671-4d3f-be32-08ddc93b0250
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:15:43.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dN3X8fS9E16/n140dw48zxXKabpLpUXRoIT+MnihBfHcueidsdKilt4okkSXJyBYE7mGexrw7MdPapQ5eHOG7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2055

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIyLCAyMDI1IDI6NTIg
QU0NCj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+
IENjOiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2YXNh
biA8a3lzQG1pY3Jvc29mdC5jb20+Ow0KPiB3ZWkubGl1QGtlcm5lbC5vcmc7IGt1YmFAa2VybmVs
Lm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5vcmc7DQo+IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IHNkZkBmb21pY2hldi5tZTsga3VuaXl1QGdvb2dsZS5jb207DQo+IGFobWVkLnph
a2lAaW50ZWwuY29tOyBhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgI0BsaW51eC5taWNy
b3NvZnQuY29tOw0KPiA1LjQrQGxpbnV4Lm1pY3Jvc29mdC5jb20NCj4gU3ViamVjdDogW0VYVEVS
TkFMXSBSZTogW1BBVENIIG5ldF0gbmV0OiBjb3JlOiBGaXggdGhlIGxvb3AgaW4NCj4gZGVmYXVs
dF9kZXZpY2VfZXhpdF9uZXQoKQ0KPiANCj4gT24gRnJpLCBKdWwgMTgsIDIwMjUgYXQgMToyMeKA
r1BNIEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6QGxpbnV4Lm1pY3Jvc29mdC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4N
Cj4gPg0KPiA+IFRoZSBsb29wIGluIGRlZmF1bHRfZGV2aWNlX2V4aXRfbmV0KCkgd29uJ3QgYmUg
YWJsZSB0byBwcm9wZXJseSBkZXRlY3QNCj4gdGhlDQo+ID4gaGVhZCB0aGVuIHN0b3AsIGFuZCB3
aWxsIGhpdCBOVUxMIHBvaW50ZXIsIHdoZW4gYSBkcml2ZXIsIGxpa2UNCj4gaHZfbmV0dnNjLA0K
PiA+IGF1dG9tYXRpY2FsbHkgbW92ZXMgdGhlIHNsYXZlIGRldmljZSB0b2dldGhlciB3aXRoIHRo
ZSBtYXN0ZXIgZGV2aWNlLg0KPiA+DQo+ID4gVG8gZml4IHRoaXMsIGFkZCBhIGhlbHBlciBmdW5j
dGlvbiB0byByZXR1cm4gdGhlIGZpcnN0IG1pZ3JhdGFibGUgbmV0ZGV2DQo+ID4gY29ycmVjdGx5
LCBubyBtYXR0ZXIgb25lIG9yIHR3byBkZXZpY2VzIHdlcmUgcmVtb3ZlZCBmcm9tIHRoaXMgbmV0
J3MNCj4gbGlzdA0KPiA+IGluIHRoZSBsYXN0IGl0ZXJhdGlvbi4NCj4gPg0KPiA+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnICMgNS40Kw0KPiANCj4gV2UgKG5ldHdvcmsgbWFpbnRhaW5lcnMp
IHByZWZlciBhIEZpeGVzOiB0YWcsIHNvIHRoYXQgd2UgY2FuIGxvb2sgYXQNCj4gdGhlIGJsYW1l
ZCBwYXRjaCwgcmF0aGVyIHRoYW4gdHJ1c3RpbmcgeW91ciAnNS40JyBoaW50Lg0KPiANCj4gV2l0
aG91dCBhIEZpeGVzIHRhZywgeW91IGFyZSBmb3JjaW5nIGVhY2ggcmV2aWV3ZXIgdG8gZG8gdGhl
DQo+IGFyY2hlb2xvZ3kgd29yaywgYW5kIHBvc3NpYmx5IGNvbXBsZXRlbHkgbWlzcyB5b3VyIHBv
aW50Lg0KDQpUaGFua3MuIEkgd2lsbCBoYXZlIHRoZSBGaXhlcyB0YWcgaW4gdGhlIG5ldyBwYXRj
aC4NCg0KLSBIYWl5YW5nDQo=

