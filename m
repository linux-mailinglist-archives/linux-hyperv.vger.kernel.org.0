Return-Path: <linux-hyperv+bounces-3193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262C9B0D06
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2024 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B56B20EE8
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60254189F50;
	Fri, 25 Oct 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dySgkSxv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022114.outbound.protection.outlook.com [40.93.195.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E420C33B;
	Fri, 25 Oct 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880344; cv=fail; b=eQSaBDzJMUrUMKwWgaU83piebGJ1oECN2Y796r127AKb+2ULJCImBEldOKMMRsp3BbxIq+JLxKOizUMvp86cv5dRV8sJh3B2RXns6y8vfmC25ERURbdDk/HGkXylQ0kZ4sYC39dmXkwH0DY0SMSkxkDouj85K8SsuNBxE7G0AE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880344; c=relaxed/simple;
	bh=mJlYmBfkHwmTmF706TlRyOVjF55pUmjz07JzlxVFlc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTpjddXLbg3sQ6/0GXVM6sgFztLyabu0Q0UN70JmL0k0L3c3tkSUM+RlZpguZ2UTU1vqJDsw12+qxKuEiZSiA9N2uo8VJcSXfzIL4DGZcZitSUum1iOAA0SaVvkQLjCc7e6AH5BWdlhn8Yiut+j0USSZISUf8F/P48cOkUbBofM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dySgkSxv; arc=fail smtp.client-ip=40.93.195.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVG71ZTY3b8XXst/wl9Ny0hZifnOmiy6xa9y28G/Op+HXrJYGtoMLXd4Qhvu+22UseqVt8L4jfnZwmwsEz2Vc6KP2hmndKHdOEKn7cPpJWrxm2p97AMuYybT+/fKl3y+g/fWCk1p1DjaKaWs2kWiQBROBlQWH2oAXtcRxTbKy1J4El3f/r7/RWIR5Cw+AS8Teq06NYA72Xo7ObLYzlin8Dlue6lYapm+vwCBYZlleFAjYK7ygZpamIWZ9Es7d7egaMFe9EXMDMYdeXSX9EjfZGD05NAQ2fqV+vCbc6S89TBcN+xWG7Y2wcI7jet74EItKzUjRYmNDowEkGKosA94ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJlYmBfkHwmTmF706TlRyOVjF55pUmjz07JzlxVFlc0=;
 b=hl66f5wTUlhvfbzwiewS8i1VBT8cyO+6O8E3s6d/jxc5M1U6EogmymIro+OyKuKPY6aIRLRPTiR1vzSagg/HqEXwZQmhLqCHc2Uo++qD6T2pIDuCzzy3/IOzh1OMbL4JLwWI2SUx0Qtq8/6yg3bfU79C6rDSbjtU9TYwQsOy+jbZkDvOdArYMFAeU0zS5oEuaapYaeBDYAfeS5CDnpDsl6mMVufWvubqdxhD+yfIGkf5NnFF9G85VojeYuEngM+t3V9pqXu1scysvGoIf1335QzLP8U/dgtC4DRwMFbRAMmc1bmVM4odNe5pkgsBSVH3EYH1ERiQ9bIMRhrreph7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJlYmBfkHwmTmF706TlRyOVjF55pUmjz07JzlxVFlc0=;
 b=dySgkSxv4Mv8lRJjmt5d1U+86U3Vi5306deAPQUbpnetdnLEcyH+TzcUc+9qZMAgx/n7OM+wlDFfxkxZNG7H8py+Llv0vJ70fFZekTaZew+9hfkAMmDpcCLQ3dY+LiMF692XokwiZ1fQo+y/xu2AwKTDsA8q5tcfQ53qtfGDHK8=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH2PPF7247630D8.namprd21.prod.outlook.com (2603:10b6:61f:fc00::146) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8; Fri, 25 Oct
 2024 18:18:59 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.8114.007; Fri, 25 Oct 2024
 18:18:59 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Naman Jain
	<namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<John.Starks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Index: AQHbIVUZK3+QpQzaU0GO9u2NqFEaQbKPwn3AgALKcYCAAIM+YIAEryvA
Date: Fri, 25 Oct 2024 18:18:59 +0000
Message-ID:
 <SA1PR21MB1317FAD9C895C085F8872899BF4F2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157F0678E2F7074A905BB64D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
 <81b0e19f-7711-4cfb-8cb1-8d4c1affc0d1@linux.microsoft.com>
 <SN6PR02MB4157FAF47E917885BFDBB9DDD44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157FAF47E917885BFDBB9DDD44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fab78077-b57b-488e-82c2-5d0195c2a737;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-25T17:12:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH2PPF7247630D8:EE_
x-ms-office365-filtering-correlation-id: c5c67920-a0d7-4b87-8120-08dcf5217f04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1JpTHF2d04xL2RhZXpjUEp1alkwZDd6b1lnRzhiUUtqWmkxY2FYaENqdkdM?=
 =?utf-8?B?dzBPWnYzc2RtOWxKbDNjUnM2QksvMFdjRzJTWU5vclZDQ3dUblZ4dWJqdmc4?=
 =?utf-8?B?ZmRpU1lkVElIaTZURVZoWGRkRnNEUVkzSFd2OUhYa3NHWDdMb0RFZytxSUdy?=
 =?utf-8?B?RllIWENrTGRZc3ZvSzFNQkE2TVJYbXIzdSs5elJYcXpFK01BS0hpQ1BDMGxR?=
 =?utf-8?B?RllGRHdGWnFXZnBhY0pXZ3FkVWlGQVRxeFhTajJ2YzZBN0Q0aU5pT0ptY1F1?=
 =?utf-8?B?OVpXNE5STEFhSnJKQ1dZL0huR3B5R3gzeUtpdk9LdmsyMmdqYlF3UnVIak5Q?=
 =?utf-8?B?MjlzMXJSQXhrbWduNm93VG5hSWNLU0w4R2JjTjF6UDRSTWxoUHZtTUFqbEpC?=
 =?utf-8?B?ZkxoWXhZY21EUGlteHhxNDF2V2JoRjJia2phWjBrajBQK2pPMHkzdFJ3bElH?=
 =?utf-8?B?cTV3cmNuTTlVUG11OTRzNmMxMXo4NTNYTEh4bDBLYTlVQTBoVXdVckRGUThm?=
 =?utf-8?B?cXhyUDd2M0dyQmNqRDRDMlhqVGxuUmsxRE4yUFBMUGIyMmI1Q0tIZ05lNjdU?=
 =?utf-8?B?T0lkbzRDWWtMSjBCQkR3Y1doRUR1bWRSU1ZLZGNaaTBFNCt6V1l4emgyaGRz?=
 =?utf-8?B?Z3RqMGVBWjBPRGF1cXBUUmhzc2duNzM3cXJldTB2WnJQT1h4cEhpeFlOUiti?=
 =?utf-8?B?dnpxdjlwdFdLaklmbHQvSVZQNU9CdFptSTFTamFMZ0pDdm5yRFJLd1VseEI2?=
 =?utf-8?B?bTlkdHhBMHd2L2xCR21HWUpUYTV4djlTT2JXSGFTWk4wdVNTNVdBK2RYRUxX?=
 =?utf-8?B?UFdpOWYrM3NPejZUd21QSldZd1dQT2ZtRlRERjFNOVplTUhwUTQrMTBiVGdH?=
 =?utf-8?B?VElFRnBHU25YVkNqdCtWdjNuTnFpRG5lOEJVRDFsM3c0ZmpzbkE5ekNwbTZ1?=
 =?utf-8?B?dlVPMUNXU21DUWJNY1lyMHB0MzA0WlVHSUJDWVErdUJQZm5aeFVacTZGMGc2?=
 =?utf-8?B?S3FYSDdJV3hpQjNyQ0lYRVU1UkNnS2djOUV3UXJzWE1McTJhVGhEWEdiOWV1?=
 =?utf-8?B?T2U5cEZuNmVEdThNTStvM0dlc0gzcWpJVm5CQVlXME5vZDRPcC8wV09RQXNN?=
 =?utf-8?B?TkVnaUp2QzB5dlY3bGg4RUtvNDJLYW9zZlpVaVd3QWdFK3NsbGZIazQ3YVFn?=
 =?utf-8?B?Qy96THRmRU4xVk8zU0xZeXVFZGx4UE5YTDJCYU5YRE01MHYxYnZYMjZqSTNX?=
 =?utf-8?B?YzFwbi83RTNSWUtDd2RJa294QWh5VmZFUUpaR1FUa1o0akhpby9VK2pFb1U2?=
 =?utf-8?B?UGR2MDY0czk1UUNKNG9zc1FyV3VyYktnSVUyN3F2SHBsZnlJUElXbTR3ZkpB?=
 =?utf-8?B?amlPMkFvcVl2aHRwanRkTmlnRUZaRCtBclFKVHhDWWlhUGlWVzZzSVgxYWw0?=
 =?utf-8?B?eU1IbWEzVmRhWUNNb2VYTk1NNHI3M1pMc28rZndsS1NSRVF6RS9KS3h5L0Q0?=
 =?utf-8?B?S0pJYlR0Q2c1TU5YMWxyd0o3Q0grQUhqQU5YRUlKa01zQ05zRGtZY2lYUEd1?=
 =?utf-8?B?b0NRTElCWHVsYnhuVnlTeit3M3lWcnJReHBia1NIWStJS0w3M0VJREJlcGdi?=
 =?utf-8?B?anc2RktGVncvb3plam8yd1F4TGZBTWo4YURGL2RVc3RMQUNXODR3ZU9OaVds?=
 =?utf-8?B?Zm9ybWRRaDh3cEx1VjdXRkFXYm52NHUyTG9KeXRJNGlkaTFMYXNKSXYvZ0x2?=
 =?utf-8?B?MHRodWo0ZXJpMUxpc1dzL2E4NklaUDRhMHQ4cVpwRFFYeGFLazdYNHFBZnVG?=
 =?utf-8?Q?uHrNpq+xOflD+2TMwvBZymEdHsgTixvSXSREQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3FLYlYvRS9RU2JoRkFWUnc2eGZRZU0wWW1wMS9RYitzQXo1Tm41aTlwUHlT?=
 =?utf-8?B?aVJEQXJ3S1lESm1UQ2FCNmMxM3FUWUpnQ1BuKzl1OXRMdnhKQ1ZzbG5qVDMy?=
 =?utf-8?B?ZEw1eU5xMndUdmZ3Z01XaUxCcm9wa0RNcnBXV0RxeWNSQzJ3NEEraENkWFps?=
 =?utf-8?B?M2ZpN1hnVVRZdWFyNVczdDBnZ3BGSHVKaUx1N1VaUDhJc3R1OThRdDFjQXYw?=
 =?utf-8?B?S1gvVWVTNDRTV1BFSXF0N1hNRHI1b1BVZTRuL05uQ3A3WlJGUzhOb2NiL04w?=
 =?utf-8?B?TXFQL3lyc2l2V041eWV3L1Y0M0VqME4yOTBLTDdwQ1U0enVLYUljQWYrOW8r?=
 =?utf-8?B?b2x6NGRpdEZFdWNaeVd2M3RuTzdzWDdFYmJuUHFGT09PQ09YelFldkN5NmY1?=
 =?utf-8?B?RE1ncTRGRGljV0F0VDlpcWxkMWFEU2IwVHBaMnZJcTZ4UGhBd1BCQmhWdjJh?=
 =?utf-8?B?WVNxeXp2VHhhVGY2MHU3Z1piSXhsdVNVVFRNeFJaTTgrUXk3TWJ0NG14SndK?=
 =?utf-8?B?NTNMaC83ZUtpcXRKVDE2bW5ZeHFqczRweFp6b3RQcDVQMGlzTDFjeDlETlNS?=
 =?utf-8?B?cFUwYm9HU3hLREwvRVdlcGpab2JHYkxXNndua1ZscFBIUytmTHlIeThldUVo?=
 =?utf-8?B?ZU0zR0pUS1pkL1hwbTVacWpWYUdzaCsyc0pwN0dUZVErZWlydzVnRHh1Qm5Y?=
 =?utf-8?B?eVU4cmgyUlRCMUY3cUJ4eUpYSFM3dDNVZnFkTFVDdVljemhVUnlSREZRWTJo?=
 =?utf-8?B?MXRDc0dXYk94ejMySU5wb2pnVENKU25xMytOQ1RUQWVQR2JjMmZSTlpodWph?=
 =?utf-8?B?czV2VHhxNE5VT0M1ckd1MEZyNWx3RFlJTXY4YVVDdFpyV0p2RHJYYTIzRUhN?=
 =?utf-8?B?ejk5eFk0SmRoUm9YdDFRN0ZUTE5kZVB6eWd3bFM2WncvMFo2ZlR6VkxmVFlV?=
 =?utf-8?B?TExyNFMyTHo4RXU2cGlCQ2Jlc25nenVSN2R1elhCSXROY0JqUE1aNmNCRmkv?=
 =?utf-8?B?NENXbzZUUWlRVG1iL3pPSGd6RU5EZGt1YnAvL1NrT1k3cHdOZlZwQ1VTM1NM?=
 =?utf-8?B?Zy9EbkRYNE5pSzVSdHdNVjVmZFhGNE5UYkhGZEZXR1FKOHV3Uit6cWxXdU1U?=
 =?utf-8?B?M3hBN0J2WnJINlRPMXJJMWlOZkZLT1BLekp1dFZhK3FIdmpHMXpGejRSNklT?=
 =?utf-8?B?eTVlRjRlNWs2R21BdUw0azNJUENUVXd5TTRLd28zYnBBK3BQek9rcktnanlM?=
 =?utf-8?B?UjhBOXFxUmZGby81dS9QSUlyODB4S2hubktoeTU2cFMwd1ZPVnRoLzFMbUc4?=
 =?utf-8?B?eTByMUpMckN5RHRrcE1Ja0NPM2hkYmpFanh5dVVyQTVGVWxkSSt5S3BxSVFF?=
 =?utf-8?B?TUpUaFQ4WkFRYlhlS3pmak9KQXE1ZFp4NDR6VnJmQXpmVUJST3hzWm1kZEVh?=
 =?utf-8?B?cjhxd3Qxdm9xWk8wYk5MQTN1Tm42MVMrV0tWSG13NE1yL3NLRG5vM1lqd2Fy?=
 =?utf-8?B?MXZUYzBuZ042NEJaUUpNL29IdHZJSktFSFdjbGxVNjAyekg3bHYyVm1CNys5?=
 =?utf-8?B?NzRmQkY3ZWN1eWx1Q0tRQ0NHZG1CWW1LUUR3OFJxdzExcFlTNHIzbExMc09x?=
 =?utf-8?B?a1A0TlBRVmlJem5XYWorSXZMaDc3aHRxa2F2V2pCZFNHYVFocWJPT2U0RHda?=
 =?utf-8?B?cE1qSFg0MDZpSFNOZWFkdzdGQkFNa1MrTHg0TFUrWmFRMnFzbXM5MFZkbTVR?=
 =?utf-8?B?UUQvQ0pVczdsVE91Y2lweFNMQzkrb2ZMOHFuZVVuZUM2VTVFZjM3WnRhc2I1?=
 =?utf-8?B?aFZhTENhWHI5cXBIOUVMQ2g0SWs3MnkzMGlDNEQ2ZW9tTHlTTEhNKzNQNWVi?=
 =?utf-8?B?TWxqdjlVQ1VtUXhCZGFkanF6c2pEZE81a2xzYmt4RG1HSHhGakxvMFprVTMx?=
 =?utf-8?B?NEErVE9uNEdlRTg3QThQTUFqc0FSUUN6a0M4K0g1NndQZkxxQ3ZvNmxVb29Z?=
 =?utf-8?B?Q0t1SFRWTTZNdkJKeHhYcmRoc1RGT0ZzVzlaa2x3OWRQU25wVkVKVE1xTlRy?=
 =?utf-8?B?aDl0VTZIVUNlNVdDT1ZFREd1NGZDNHl4enlaMXcyVU44WE9vcUlLZTY0bGJW?=
 =?utf-8?B?YUxmZDFqRXdXNkhKSVBMdzNXQlpQdlU3ZU1HRUNtRExnM1I3QTRSdUNsaXN6?=
 =?utf-8?Q?upGTVUigNFU8ceCtLTR5g+8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c67920-a0d7-4b87-8120-08dcf5217f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 18:18:59.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GX1N4uYvkBwwpp9cXosdzQkQlZ/boSp8hGJumXwaH2htWD9eJtqfHzjQW8cVs3uqaPrzFv2T79mPfXHmjZcksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF7247630D8

PiBGcm9tOiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgMTE6MDQgQU0NCj4gWy4uLl0NCj4gSSB3YXNuJ3QgYXdh
cmUgb2YgdGhlIFZGIGhhbmRsaW5nLiBXaGVyZSBkb2VzIHRoZSBndWVzdCBub3RpZnkgdGhlDQo+
IGhvc3QgdGhhdCBpdCBpcyBwbGFubmluZyB0byBoaWJlcm5hdGU/IEkgd2VudCBsb29raW5nIGZv
ciBzdWNoIGNvZGUsIGJ1dA0KPiBjb3VsZG4ndCBpbW1lZGlhdGVseSBmaW5kIGl0LiAgSXMgaXQg
aW4gdGhlIG5ldHZzYyBkcml2ZXI/IElzIHRoaXMgdGhlDQo+IHNlcXVlbmNlPw0KPiANCj4gMSkg
VGhlIGd1ZXN0IG5vdGlmaWVzIHRoZSBob3N0IG9mIHRoZSBoaWJlcm5hdGUNCj4gMikgVGhlIGhv
c3Qgc2VuZHMgYSBSRVNDSU5EX0NIQU5ORUxPRkZFUiBtZXNzYWdlIGZvciBlYWNoIFZGDQo+ICAg
ICBpbiB0aGUgVk0NCj4gMykgVGhlIGd1ZXN0IHdhaXRzIGZvciBhbGwgVkYgcmVzY2luZCBwcm9j
ZXNzaW5nIHRvIGNvbXBsZXRlLCBhbmQNCj4gICAgIGFsc28gbXVzdCBlbnN1cmUgdGhhdCBubyBu
ZXcgVkZzIGdldCBhZGRlZCBpbiB0aGUgbWVhbnRpbWUNCj4gNCkgVGhlbiB0aGUgZ3Vlc3QgcHJv
Y2VlZHMgd2l0aCB0aGUgaGliZXJuYXRpb24sIGtub3dpbmcgdGhhdCB0aGVyZQ0KPiAgICAgYXJl
IG5vIG9wZW4gY2hhbm5lbHMgZm9yIFZGIGRldmljZXMNCg0KV2hlbiBhIGhpYmVybmF0ZWQgVk0g
cmVzdW1lcyBvbiBhIGRpZmZlcmVudCBob3N0LCBpdCBsb29rcyBsaWtlIHRoZSBob3N0IHRlYW0N
CnRoaW5rcyB0aGF0IGl0J3MgZGlmZmljdWx0IHRvIHJlbWVtYmVyIHRoZSBWTUJ1cyBkZXZpY2Ug
SW5zdGFuY2UgR1VJRCBmb3IgdGhlDQpWRiwgYW5kIHVzZSB0aGUgc2FtZSBHVUlEIG9uIHRoZSBu
ZXcgaG9zdC4gV2hlbiB0aGUgbmV3IGhvc3QgdXNlcyBhIG5ldw0KSW5zdGFuY2UgR1VJRCBmb3Ig
dGhlIFZGLCBhIFdpbmRvd3MgVk0gcGFuaWNzLCBhbmQgYSBMaW51eCBWTSBwcmludHMgYQ0Kd2Fy
bmluZyBhbmQgSUlSQyBsb3NlcyB0aGUgYWJpbGl0eSB0byBoaWJlcm5hdGUgYWdhaW4gZHVlIHRv
IGEgY2hlY2sgaW4gdGhlDQpWTUJ1cyBkcml2ZXIuDQoNClNvLCBhcyBhIHdvcmthcm91bmQsIHRo
ZSBob3N0IHRlYW0gZGVjaWRlcyB0byByZW1vdmUgdGhlIFZGKHMpIGJlZm9yZQ0KYXNraW5nIHRo
ZSBWTSB0byBoaWJlcm5hdGUuIFRoZSBzZXF1ZW5jZSBvZiBhICJob3N0LWluaXRpYXRlZCBWTSBo
aWJlcm5hdGlvbiINCmlzOg0KMSkgYSB1c2VyIGNsaWNrcyB0aGUgIkhpYmVybmF0aW9uIiBidXR0
b24gb24gdGhlIHBvcnRhbCAob3IgdXNlcyB0aGUgZXF1aXZhbGVudA0KY21kIGxpbmUgb3IgQVBJ
KS4NCg0KMikgSW50ZXJuYWxseSwgdGhlIGhvc3QgdGVtcG9yYXJpbHkgZGlzYWJsZXMgQWNjZWxO
ZXQgZm9yIHRoZSB2TklDcywgaS5lLiBzZW5kaW5nDQpQQ0lfRUpFQ1QgYW5kIFJFU0NJTkRfQ0hB
Tk5FTE9GRkVSIGZvciBlYWNoIFZGLg0KDQozKSBUaGUgZ3Vlc3QgcmVzcG9uZHMgYWNjb3JkaW5n
bHksIGluY2x1ZGluZyBzZW5kaW5nIFBDSV9FSkVDVElPTl9DT01QTEVURQ0KYW5kIENIQU5ORUxN
U0dfUkVMSURfUkVMRUFTRUQuDQoNCjQpIE9uY2UgdGhlIGhvc3Qga25vd3MgdGhhdCBBY2NlbE5l
dCBoYXMgYmVlbiBkaXNhYmxlZCBmb3IgdGhlIFZNLCB0aGUgaG9zdA0KU2VuZHMgYSAicGxlYXNl
IGhpYmVybmF0ZSIgbWVzc2FnZSB0byB0aGUgZ3Vlc3QgdmlhIHRoZSBTaHV0ZG93biBJQy4NCg0K
NSkgVGhlIGd1ZXN0IHByb2NlZWRzIHdpdGggdGhlIGhpYmVybmF0aW9uLCBrbm93aW5nIHRoYXQg
dGhlcmUgYXJlIG5vIG9wZW4NCmNoYW5uZWxzIGZvciBWRiBkZXZpY2VzIGFuZCBhc3N1bWluZyBu
byBuZXcgVkYgd2lsbCBiZSBvZmZlcmVkIGR1cmluZyB0aGUNCmhpYmVybmF0aW9uIG9wZXJhdGlv
bi4NCg0KNikgV2hlbiB0aGUgVk0gZmluaXNoZXMgaGliZXJuYXRpb24gYW5kIHBvd2VycyBvZmYs
IHRoZSBob3N0IGludGVybmFsbHkgZW5hYmxlcw0KQWNjZWxOZXQgZm9yIHRoZSBWTSBzbyB0aGF0
IHdoZW4gdGhlIFZNIHJlc3VtZXMgb24gYSBuZXcgaG9zdCwgdGhlIG5ldyBob3N0DQpjYW4gb2Zm
ZXIgYSBWRiB3aXRoIGEgZGlmZmVyZW50IFZNQnVzIGRldmljZSBpbnN0YW5jZSBHVUlELg0KDQpU
aGUgYWJvdmUgaXMgZm9yIGEgImhvc3QtaW5pdGlhdGVkIFZNIGhpYmVybmF0aW9uIi4NCg0KQ3Vy
cmVudGx5LCB0aGUgQXp1cmUgdGVhbSBkb2Vzbid0IHN1cHBvcnQgYSAiVk0taW5pdGlhdGVkIGhp
YmVybmF0aW9uIiwgd2hlcmUNCnRoZSBob3N0IGhhcyBubyBvcHBvcnR1bml0eSB0byB0ZW1wb3Jh
cmlseSBkaXNhYmxlIEFjY2VsTmV0LiBNYXliZSANCiJWTS1pbml0aWF0ZWQgaGliZXJuYXRpb24i
IGNhbiBiZSBzdXBwb3J0ZWQgd2hlbiBNQU5BLURpcmVjdCBpcyB1c2VkIChpLmUuDQpubyBtb3Jl
IE5ldFZTQyBOSUNzIGFuZCB0aGVyZSBhcmUgb25seSBNQU5BIFZGIE5JQ3MpOiBpbiB0aGlzIHNj
ZW5hcmlvLCBJDQpzdXBwb3NlIHRoZSBob3N0IG11c3QgcmVtZW1iZXIgdGhlIE1BTkEgVkYncyBW
TUJ1cyBkZXZpY2UgSW5zdGFuY2UgR1VJRA0KYW5kIHVzZSB0aGUgc2FtZSBHVUlEIG9uIHRoZSBu
ZXcgaG9zdC4NCg0KPiA+IFRoZSBiZWhhdmlvciB3ZSB3YW50IGlzIGZvciB0aGUgZ3Vlc3QgdG8g
aG90IHJlbW92ZSB0aGUgTUxYIGRldmljZQ0KPiA+IGRyaXZlciBvbiByZXN1bWUsIGV2ZW4gaWYg
dGhlIE1MWCBkZXZpY2Ugd2FzIHN0aWxsIHByZXNlbnQgYXQgc3VzcGVuZCwNCj4gPiBzbyB0aGF0
IHRoZSBob3N0IGRvZXMgbm90IG5lZWQgdGhpcyBzcGVjaWFsIHByZS1oaWJlcm5hdGUgYmVoYXZp
b3IuIFRoaXMNCj4gPiBwYXRjaCBzZXJpZXMgbWF5IG5vdCBiZSBzdWZmaWNpZW50IHRvIGVuc3Vy
ZSB0aGlzLCB0aG91Z2guIEl0IGp1c3QgbW92ZXMNCj4gPiB0aGluZ3MgaW4gdGhlIHJpZ2h0IGRp
cmVjdGlvbiwgYnkgaGFuZGxpbmcgdGhlIGFsbC1vZmZlcnMtZGVsaXZlcmVkDQo+ID4gbWVzc2Fn
ZS4NCg0KSSdtIG5vdCBzdXJlIGlmIGl0J3MgYSBnb29kIGlkZWEgdG8gYWRkIG5ldyBjb2RlIHRv
IHRyeSB0byByZW1vdmUgYW4gDQpzdGFsZSBNTFggVkYgc2luY2UgdGhlIHNjZW5hcmlvIHNob3Vs
ZCBub3QgZXhpc3Qgb24gQXp1cmUgbm93YWRheXMgDQooY3VycmVudGx5IHRoZSBob3N0IHRlbXBv
cmFyaWx5IGRpc2FibGVzIEFjY2VsTmV0IGR1cmluZyBoaWJlcm5hdGlvbiBzbyB0aGVyZQ0Kc2hv
dWxkIGJlIG5vIHN0YWxlIE1MWCBWRiB1cG9uIHJlc3VtZS4pDQoNCk9uIGEgbG9jYWwgSHlwZXIt
ViBob3N0LCBhZnRlciBhIFZNIGhpYmVybmF0ZXMsIHdlIGNhbiBtYW51YWxseSBkaXNhYmxlDQpB
Y2NlbE5ldCAoaS5lLiBOSUMgU1ItSU9WKSBmb3IgdGhlIFZNLCBhbmQgdGhlIFZNIHdpbGwgc2Vl
IGEgc3RhbGUgdW5yZXNwb25zaXZlDQpNTFggVkYgdXBvbiByZXN1bWUuIEl0IHdvdWxkIGJlIHRy
aWNreSB0byBjbGVhbiB1cCB0aGUgVkYgZ3JhY2VmdWxseToNCndlIHdvdWxkIGhhdmUgdG8gd2Fp
dCBmb3IgdGhlIHJlc3VtZSBjYWxsYmFjayBpbiB0aGUgTWVsbGFub3ggVkYgZHJpdmVyDQp0byB0
aW1lIG91dCBvbiB0aGUgdW5yZXNwb25zaXZlIFZGICh0aGlzIGNhbiB0YWtlIDEgbWludXRlKSBh
bmQgY2xlYW4gdXAgdGhlDQpyZWxhdGVkIFZNQnVzIHBhc3MtdGhyb3VnaCBkZXZpY2UgYmFja2lu
ZyB0aGUgVkY7IHdoYXQgaGFwcGVucyBpZiBhDQpob3N0LWluaXRpYXRlZCBvciBWTS1pbml0aWF0
ZWQgaGliZXJuYXRpb24gaXMgdHJpZ2dlcmVkIGR1cmluZyB0aGUgMSBtaW51dGU/DQpJIHN1c3Bl
Y3QgdGhlcmUgbWF5IGJlIHNvbWUgdHJpY2t5IHJhY2UgY29uZGl0aW9uIGlzc3VlcywgZS5nLiB3
ZSBtYXkgDQpuZWVkIHRvIGZpZ3VyZSBvdXQgaG93IHRvIHN5bmNocm9uaXplIHRoZSAucmVzdW1l
IHdpdGggdGhlIC5yZW1vdmUgY2FsbGJhY2tzDQpvZiB0aGUgTUxYIGRyaXZlci4NCg0KSSB0aGlu
ayB0aGUgZ2VuZXJhbCBhc3N1bXB0aW9uIGlzIHRoYXQgdGhlIFZNJ3MgY29uZmlndXJhdGlvbiBz
aG91bGQgbm90DQpjaGFuZ2UgYXQgYWxsIGFjcm9zcyBoaWJlcm5hdGlvbiwgYnV0IGl0IGxvb2tz
IGxpa2UgdGhpcyBhc3N1bXB0aW9uIGlzIGZvdW5kDQp0byBiZSBmYWxzZSB1bmRlciBzb21lIGNv
bmRpdGlvbnMgZnJvbSB0aW1lIHRvIHRpbWUuLi4gSSB3aXNoIHRoZSBhc3N1bXB0aW9uDQpjYW4g
YmUgYWx3YXlzIHRydWUgd2l0aCBPcGVuSENMLg0KDQpUaGFua3MsDQpEZXh1YW4NCg==

