Return-Path: <linux-hyperv+bounces-6326-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E05B0E197
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066253B9A39
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC48279323;
	Tue, 22 Jul 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a8BIioUe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020129.outbound.protection.outlook.com [40.93.198.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1991D90A5;
	Tue, 22 Jul 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201236; cv=fail; b=a9NbNOQEFNjvzWaEl+7R/3zQyPcWUczW/HYsNrTmFoEmRUcfWJldUq1YDRRhTmibX8Y115HTpdpY23WZFXLY4WWNsDhQqkxFvKXTLksC3OwYwydCv68lV4wTTs9CXAPic3H9r5dThTr33JL4Ko2v8PjcoxbB6Hv3NeR0avNnNIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201236; c=relaxed/simple;
	bh=rJq3K6yxR/6sHwbAFfn1/m2TwW5JAWildgP0+1CBo+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEbP4xbKt17Zrr5cBi5en4RWgzksRAzSFuEi6QHw9pNRWNt6+bo0QC+3knCiQfbWF9sF+KQGQSO/iI5VHl9CG5/4R2IZ3L5HN7QUiuh2+2NDtLHnr8xXViV+RJSTFeP3ORIkxwz0mEXQEzD0PBv0+pJuIehxkB7Hq1BsLs7QR1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=a8BIioUe; arc=fail smtp.client-ip=40.93.198.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTvsIrCNsKUvxoyYpcaJ6nBJGkGJFFT9tQ7xkVP0brEuqj5i0JjxCpICcsk7F72IdTdNisyJcwXE8aAqcYgzRD0pVJsaxpmLWYSItszepz6usiAEs2ymtIf89K2omHEo/CH3uPHhLEQYnIzAeK3kmDAaA88v7DORCqV8G4BwpmFppIb/pEcK7N0KGDlPMuvisV5fE67Blm25Zh/Kk4VOOsSnj9xOecrp9Up2h6v8TOxw5AzIynhQu6J/ypYL63OHhv4sf1HVRvo7C1ExN+5X9Up2GDdkTvIUdkK5S95NeDk5wfffheCL5yloGEr/s43hfMEd5J6xhuS2eY7XHt4Mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJq3K6yxR/6sHwbAFfn1/m2TwW5JAWildgP0+1CBo+Q=;
 b=iNYkjUUjMflr7DfAiKmQmiApM/qcZ34BOisOpJaCZ7+ZQFN7xPfPVYPxuD4EUKnJ9GUzpP8PcSEv/jFS3Op2TcBWB11gWp61eot0hkM+J5IQ4S+2RcVU0vsmqSgmL2OLMc2H5wH8oe5Hgh3JVXp9SwbNzMw7X0t/Q4iJ4IkZRP7ks3oOjsQNVymQ4xYxab8GEvAJjvkcHN7DZ3MIEb6J/jiZSFjgge1Xs5Dl/csll0HiXpRadIPga5izoqGw0U5kQnXiCcFs5R7CwVWYdkqe3w6HRPxmI6bIbh5vD6b2RIaBYa5juPmVA0bRk0QAVh7yc0w47qLHmDvmmlEKsKV/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJq3K6yxR/6sHwbAFfn1/m2TwW5JAWildgP0+1CBo+Q=;
 b=a8BIioUeZXw9mzojJf3XE/6WJGAXdL9Pj7a7d0CWAKt4CO0yLOwTym0RKOEoGR5GNVEjOyeorIRSdmqvwQ7Ep0JVHb8t8HhufEBQgBeRdfPbmVcWoyoVT7UVqnEL2dxat5W6/iKvGfY12geGabh7Kz1ZLVmQgUFuHsyzm/0a460=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ0PR21MB2055.namprd21.prod.outlook.com (2603:10b6:a03:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.18; Tue, 22 Jul
 2025 16:20:31 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Tue, 22 Jul 2025
 16:20:31 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: core: Fix the loop in
 default_device_exit_net()
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: core: Fix the loop in
 default_device_exit_net()
Thread-Index: AQHb+CF8hOfRUrm9+kmaxTYS2+tsGbQ4iY+AgAFi5oCABGucEA==
Date: Tue, 22 Jul 2025 16:20:31 +0000
Message-ID:
 <SJ2PR21MB401389FA98D182F16154E64ACA5CA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250718163723.4390bd7d@kernel.org>
 <CAAVpQUC_sH2UDdf0e5c=iPFU5EcaB7YeN=__2j6w_h6_pe8m_g@mail.gmail.com>
In-Reply-To:
 <CAAVpQUC_sH2UDdf0e5c=iPFU5EcaB7YeN=__2j6w_h6_pe8m_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a2aaed06-70c1-4ab2-b8b1-346d3be918bb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-22T16:17:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ0PR21MB2055:EE_
x-ms-office365-filtering-correlation-id: 2ce2b002-153c-47e1-3a3d-08ddc93bae0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlpDT3VUU1JrSVpoWHo5VmxJRWVnNm1jbWxZbENRSFU2anVWQXlNYzhNc2lE?=
 =?utf-8?B?M1lOQnR6elJHbW9GVnFpZWNINmhtTVI4bzRSak9PMHFvQUVrMmdKS2lMeHpq?=
 =?utf-8?B?SWlPZGFpY1JlbFh1MENnd2lQWHBGOXhQdVJHUGpOTThNQ05mUzBESmdSV2Ju?=
 =?utf-8?B?YkV2SGQ4c0RhRUsvN1NTcXM3d1ZzakFaeiswOW9BdjU0RW53NlZKakszU2tR?=
 =?utf-8?B?SVZRay91NGl6UzRFSjBtdlNMVkdxQzRNUVlwamtPazlGbFNWR2xDRkppSEdx?=
 =?utf-8?B?OHcrN29MZDlyR28rZkw4TmJSMjZyYWc4Q2dCblp6R2hTLzdMU2ZiSGdxRVRz?=
 =?utf-8?B?UzkwdlhPUnlVKzlwNDFzek16M1I3Vy9XUXpnSGgxRCtsR3FsVHFwelVyOGFm?=
 =?utf-8?B?WFRYL09GZHIwajBLT2MwaEdBRWRuenB4R0NwazJZVVhTeklMWEp3SitsREUx?=
 =?utf-8?B?UmFUTHFkaXI0YlZVd2h4b09aTjVodlB4YkV2LzdFeFpuaW5jYk9NMVdvVmxZ?=
 =?utf-8?B?M2YwZjdoLzh0MmI3TSthUG5QZStRTVJabll3dmxIRVlwZE1pQU5QcEt6OCsr?=
 =?utf-8?B?VEh4alF4eXBxVUhpOXMzeU9TNThPcCt1R0pLNklXck9pMHJxaGIxNmJpQ0Fi?=
 =?utf-8?B?K2Vvcm9MKy9YcXhXY0RoTXNLNXRudVR6RENPTjVvdWk0THhWa0t4ZE5ZcGJJ?=
 =?utf-8?B?ZllVRHhXNU15Q2dGYlNVeGVuRHdnOE1abWxDdWVaQ0NaR2Y1OTlUb2VWKyt0?=
 =?utf-8?B?UWNJZ1gzbStFZmhGVlhZTkl5UU96TEtUV2dlUGRTcXpPWmlTcUFkUUhEcW1H?=
 =?utf-8?B?a2pnWXBlbzZrdHlIeEVLc0Zsejk0bEkzWHNENnozUFJRbDdpTjZHd3E0K1Fo?=
 =?utf-8?B?WkdpUCt2dXMzREY5UkE4ekFzckhsWVZMZVZtZnZ5cVdnSEpxVldLcm1Tei9P?=
 =?utf-8?B?WkJmSVpCd3RZMVB3NWpYTVNzUVRybjJaRlkxWnJ0dzJpUzJXcmZaRWg0eDlN?=
 =?utf-8?B?dldYb2dNamxyYVlLcXI4NUZqZldhOTZrSEVlWFJNYVQya3pMamR0VkV2MjFj?=
 =?utf-8?B?TlpKa1d3QU9aeHRjN1IrdXFqZ1crTFVkeVlFT1kxZ09TMjVoRU14MDV0dUJK?=
 =?utf-8?B?dzJmb3NyTVRnellCZFRxWlA0SWdWd0h0R3FTQTRaV3d5YXBHQkFNTTJJZXJw?=
 =?utf-8?B?eU9WckQ2SmxITEJDV1pURWM2T0h0QlVha2hwakVLTTk5bkFEOGJramNxZ0pp?=
 =?utf-8?B?U2x2bWZ4UUZUWXA2Z3FyYjRXSkRTbUNDRkV6dVdTMDI4Nkd2c3RDSHJ0SWd3?=
 =?utf-8?B?OVFlZ3M5UXVxaEJIRW5VcUxkZTBwK0I0ditqYkE3YUlNWlRZa3JPK29pT3lY?=
 =?utf-8?B?ZFQ3b1I2K2tqVVVOK1NQVE9XS1liM2FPSEtxQkVJYmk5S01CMUZaWTlra2s3?=
 =?utf-8?B?cVViYkMwNms5VU1wSDlLWkkvWnhwVTlXVHZCVGxkejNtczRZN0lmc0hFUERO?=
 =?utf-8?B?VFpjQTBZV0Rxc2Z5SERhdUl0bE54TFUvMWtUZ0tZTUFnRGNBSUQrOWdlNzdq?=
 =?utf-8?B?Y3J2R3JwRlcwNHF3L2Vlc0czQStCNXVOdTZ4Rm00YWc4S0xsSUgzNzV1Kzcr?=
 =?utf-8?B?dGpGOURucmJSNGhNb3hoL0NNcW8vWTdSbm5kNWdJZm4wajhVaFZKT0oxUVhx?=
 =?utf-8?B?UUxIazg0YUdhUFdjMU5tTlRPcGNzRE5QWldnODh1MUlHNmphYjVxOGFlcDBH?=
 =?utf-8?B?bDA5M0R3UFhiQ1NIcUhtSEYwSGp5aUN4d0l5Z2F0MjBNckxsM3hZdnY1RWhI?=
 =?utf-8?B?RlFIYm13b0d5elNMTjNPaTk2eWlSbVNnTmVmM3hQR3l1NnZOMlpZZ0FsakN0?=
 =?utf-8?B?cXFuM1FwM2g0c3BHZmliZ284NWN4cGFtUHZmb0ZQODVjWHFxM3NLMGg0d0Nl?=
 =?utf-8?B?ZFNPcTFsR0J3THdzdFlnRW9veDh6MU04NkRLbFQ5TGRPTzc0Tk1DSCtLMmF5?=
 =?utf-8?B?c2h1S3ZoNkpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEJKdFdMNVFja294ZmRDcGpoV2V6ZjBtSFRRYWFIdkNIQXdwY3BFSEw3WWFR?=
 =?utf-8?B?aGN6UmUxV1FvclM1Z0d5bWRmTm5CbENoNEs3Ry9wclZxL3Z4eTgveUJ3TGFw?=
 =?utf-8?B?OGdacy92dVFBdEkxTmdUeUY4c1VVOFlFQ0FvaHIxVnI1Y0ZDRG5tN1VCZHJv?=
 =?utf-8?B?dERUaEpjUEtWUU41aDMydzZzUXM4dmVXamNQSmtqbHJuSVdVYWNaTWF0M3NG?=
 =?utf-8?B?cUgzeHg0YTZwYmQ1cTAvUnlSbVc2eUtsTjZlM0dRNERaZWdSaU5yNHlmMzl6?=
 =?utf-8?B?azBaYTZpMHZMODZPSHRKd0RIeGVCTnpJRnJ4UWlBaEhiOUs2NEtLa3JCakEz?=
 =?utf-8?B?eEV2M1JCMkR3WkVMRXovNXRHbVJ0Vmx6Z01wNUd1d0hBZVZ1VlRPWWdFTUo4?=
 =?utf-8?B?ZUlrL0syR0ZBODdhaUo2RkxQT3JUVFc1Njl2UjE0UTE0Q01UVitPTW1SbTRY?=
 =?utf-8?B?cWNVZ3YzcDdtZUNxSHc5cEEwTFlwK3pod3R1eXpEaWdPRURyZEw5dUllN1lx?=
 =?utf-8?B?MXFkRnZJVHkvU0JLdW5hMmlKUGFvVXlROEhMdTMyc1pROVR1ZFZ1eGN3Q0lq?=
 =?utf-8?B?c2ZwQjVXMXFXSm9NamNZRFFQUXYwYU96ZnhDbkd2YXF2WEtMK01Ta1daUVJx?=
 =?utf-8?B?MHRNQ2taTTRDQ3ZURmhkZ1cvd21TL1dzd205Yjc3blZwRGk4VGlFeUlQRmZM?=
 =?utf-8?B?WDl1SUdZcFRZYnhVbnY5K092eXU3emc5eDg1L1RVQnlDaUVQaTdGUVBPaXZV?=
 =?utf-8?B?S1BDU0szYUFmTGw2cjBiZ25CVkpYVnZGWjBLZ3RhcjRvNlFIMmlBK3U1QWN5?=
 =?utf-8?B?WEhVSkJWcE5ES05jZ0oyRWJ2Z3NJbVBYdnFVT29tdFFGU2NnTlpxZys2anhL?=
 =?utf-8?B?eDUxVnczQnlXVWNSaEdnOXhrRCt3SGhmbFhRVnQ5SzhYaXlqNkRpaWNQTTV6?=
 =?utf-8?B?MXhDWlJSTUF5QVlWYXk3YmszUWtGcmZSTENYb0ZaRDdZZ0lCQUwvVnpuODZp?=
 =?utf-8?B?dkdLakJ2RUFQdktETUJTYkZ3cVBLVlEzazVSdnl4UzFtU1ZMemdyeThWbFU2?=
 =?utf-8?B?RlVJeE43QkJ2MVpQVWpGVFNycmFLL2hhSDVEcEMzTkZHWGFJUWIvSzJwNWhs?=
 =?utf-8?B?Zm5Jck12SXNWaWlkdCtXVkFOVG82VWFqcnYwS2tzZmw3UVVUa1ltTHJ0eWxF?=
 =?utf-8?B?TXdQWlFSQ0U0OUxjM09ITWZWaXkvSTFPVnBXemZOVnpMeHhlNW9nU1NDZjdH?=
 =?utf-8?B?RkFzdUt3RTY4K1JwRjE0QWdNdVJyWFZ6bUlmbmJBYjU5ZVBjUk1pY2dQL0Zx?=
 =?utf-8?B?Q0hDVzBUN0NtbzRhZnQxSmZhdU82aWJyUlRYazNVdUJGdTM5czE0ZHFrMCs2?=
 =?utf-8?B?aEZXb3VMNitzdVlvQ3VpTzYxWE9kMTNUYld4K0ltSnhDRm9JVU1saTRJZTJB?=
 =?utf-8?B?MzdYNDJOalpYZ01uWXBIclhGMkpGVTFkUzN2T1krVDZDSzY3ZC9GR3Uzc21L?=
 =?utf-8?B?VnoyaWRVUTZnUFlJOGM3WkQ1SXh5bWpDTW9UOVVxZ1RSekNIaGJyTS9VSVdS?=
 =?utf-8?B?MW5uSk1SeGdMbVJMUHlUUFNuMUtCYmh4U1ZnUXdORW5JWnFCMlhTeEpTOTZv?=
 =?utf-8?B?S1IrdW10NXFZRllRNWZpclZmL1dybERjMy9sSC9ON3M4VFB6aFpFRStCemJE?=
 =?utf-8?B?OHd4Zmk4cTFodnJvazgwdGJGVDFmd2pOdWZRNTdrNmQyWDZsa29zWmk5dnFF?=
 =?utf-8?B?SVZGbGZhcXkvRXBEQThlV3hsQ1IrR2lQcHArUVFXdnFhYlVHdXJORlBndXNY?=
 =?utf-8?B?M2hrajRNOTdMdjNXWkp4ZUFhTnJ3YXJ3RXY2TjNLcFoxc1FpUU9vVWc5Z3hq?=
 =?utf-8?B?aHZCTVREUDhNYmUyZ1hJdlJQaEVDNE1MM05wTGtjejgyelpFb09TUWNiUGMv?=
 =?utf-8?B?NEM2RlRBbzNSaC8xQkZYTHFNbjcxc1BQL0hZU2dqbXh1a2ZWSUtiam9Zbmts?=
 =?utf-8?B?WEpWb3NzcHlLTjdSR2FyR084b1dWSUxteFZjRkZLV2xHc0pYWXpva1p5V2J3?=
 =?utf-8?B?OEMrU2VYYWJhbG9iRVdiSUw2K1VRdEFNRmRDSk14bTlNci8rUThzTENXNFVs?=
 =?utf-8?Q?h/akIgNm77djTDoQVdsi8tjJF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce2b002-153c-47e1-3a3d-08ddc93bae0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:20:31.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vk3R5BG6JTHgAmI4WxrhRpkxAsA7aZS8DVA6IaePsFYhrDUfam5QS9DZ+iiBAmR+CnWbObDYKHSisHKYjmzJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2055

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VuaXl1a2kgSXdhc2hp
bWEgPGt1bml5dUBnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAxOSwgMjAyNSA0
OjQ4IFBNDQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBDYzogSGFp
eWFuZyBaaGFuZyA8aGFpeWFuZ3pAbGludXgubWljcm9zb2Z0LmNvbT47IGxpbnV4LQ0KPiBoeXBl
cnZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBIYWl5YW5nIFpoYW5n
DQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29m
dC5jb20+Ow0KPiB3ZWkubGl1QGtlcm5lbC5vcmc7IGVkdW1hemV0QGdvb2dsZS5jb207IHBhYmVu
aUByZWRoYXQuY29tOw0KPiBob3Jtc0BrZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBz
ZGZAZm9taWNoZXYubWU7DQo+IGFobWVkLnpha2lAaW50ZWwuY29tOyBhbGVrc2FuZGVyLmxvYmFr
aW5AaW50ZWwuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0XSBuZXQ6IGNvcmU6IEZpeCB0aGUgbG9vcCBpbg0K
PiBkZWZhdWx0X2RldmljZV9leGl0X25ldCgpDQo+IA0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBl
bWFpbCBmcm9tIGt1bml5dUBnb29nbGUuY29tLiBMZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4g
DQo+IE9uIEZyaSwgSnVsIDE4LCAyMDI1IGF0IDQ6MzfigK9QTSBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMTggSnVsIDIwMjUgMTM6MjA6
MTQgLTA3MDAgSGFpeWFuZyBaaGFuZyB3cm90ZToNCj4gPiA+IFRoZSBsb29wIGluIGRlZmF1bHRf
ZGV2aWNlX2V4aXRfbmV0KCkgd29uJ3QgYmUgYWJsZSB0byBwcm9wZXJseSBkZXRlY3QNCj4gdGhl
DQo+ID4gPiBoZWFkIHRoZW4gc3RvcCwgYW5kIHdpbGwgaGl0IE5VTEwgcG9pbnRlciwgd2hlbiBh
IGRyaXZlciwgbGlrZQ0KPiBodl9uZXR2c2MsDQo+ID4gPiBhdXRvbWF0aWNhbGx5IG1vdmVzIHRo
ZSBzbGF2ZSBkZXZpY2UgdG9nZXRoZXIgd2l0aCB0aGUgbWFzdGVyIGRldmljZS4NCj4gPiA+DQo+
ID4gPiBUbyBmaXggdGhpcywgYWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRvIHJldHVybiB0aGUgZmly
c3QgbWlncmF0YWJsZQ0KPiBuZXRkZXYNCj4gPiA+IGNvcnJlY3RseSwgbm8gbWF0dGVyIG9uZSBv
ciB0d28gZGV2aWNlcyB3ZXJlIHJlbW92ZWQgZnJvbSB0aGlzIG5ldCdzDQo+IGxpc3QNCj4gPiA+
IGluIHRoZSBsYXN0IGl0ZXJhdGlvbi4NCj4gPg0KPiA+IEZUUiBJIHRoaW5rIHRoYXQgd2hhdCB0
aGUgZHJpdmVyIGlzIHRyeWluZyB0byBkbyBpcyB3YXkgdG9vIGhhY2t5LCBhbmQNCj4gPiBpdCBz
aG91bGQgYmUgZml4ZWQgaW5zdGVhZC4gQnV0IEkgZGVmZXIgdG8gS3VuaXl1a2kgZm9yIHRoZSBm
aW5hbCB3b3JkLA0KPiA+IG1heWJlIHRoaXMgY2hhbmdlIGlzIHVzZWZ1bCBmb3Igb3RoZXIgcmVh
c29ucy4uDQo+IA0KPiBJIGFncmVlIHRoYXQgaXQgc2hvdWxkIGJlIGZpeGVkIG9uIHRoZSBkcml2
ZXIgc2lkZS4gIEkgZG9uJ3QNCj4gdGhpbmsgb2YgYSBnb29kIHJlYXNvbiBmb3IgdGhlIGNoYW5n
ZS4NCg0KS3VuaXl1a2kgYW5kIEpha3ViOg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLiBJJ20g
d29ya2luZyBvbiBhIHBhdGNoIHRoYXQgd2lsbCBmaXggdGhlIGRyaXZlciBzaWRlLg0KDQotIEhh
aXlhbmcNCg0K

