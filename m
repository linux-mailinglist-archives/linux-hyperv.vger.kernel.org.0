Return-Path: <linux-hyperv+bounces-6849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466DAB557DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743711CC661C
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF42D3EDD;
	Fri, 12 Sep 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GZ/E9BnV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021076.outbound.protection.outlook.com [52.101.52.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E515C0;
	Fri, 12 Sep 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710041; cv=fail; b=lN+k3srCCTrO1GYJHabS71Tz4uGePkEYrk/n3I/7E7bQmx3pmdADMS6Qido5cY/mbkuekZvUkRKz3ybOSSK/2sjq1GodMACb4L45qUsYJixilMXFKmZVjlfKPwukSh+5qiMa723gyGLLKSkyip5p+PoQxtDs4wCaO1ryD9GTMrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710041; c=relaxed/simple;
	bh=OaoCh6XWRWjHpAXKdoDb/xUELYwO+sl3E2X+Nt9NLHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLJ1hYnYj3P6acNI+26N8uwc95Fe5S/KyLRmMwJphgEgjV5qqjOfWJhpmmlMWzEt4aK8xo09enKTJmwoTv0JOQNCB5e3cXYsGquUUyxO4uCbB8juyG/Ax9ATRdPpw0myZaXlU+qRe+FNsBmeST5Lp6vCC6EI/4roGblMAxiL+0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GZ/E9BnV; arc=fail smtp.client-ip=52.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9SlHb7aqdQ5+X3NDsPLjlNosKMKN2MfSQbtTir2iQf+7IdAEpcU/OGBNrArNDA94wvuSQagBofilByJV8+r7vLzBYtOclfls8B/EuRgsf4aqsX4det97f1K2/zkRDDuYDLSUZ7Vnvtsyx6bqJDHZf2AySw+5FQo+SQNAWkqxrnJ1focbhzJRL/0Xd9BvXg08fcfnlpYeZ+tGugmr5ZdiBHzqKa21NXZ66+CNAbiBHF7C5CLnGXlXWmzOnb6Sq1a+WErPVsMweOD9zWCu29jDBVGZJk3snH3EYRmyXjLr8ttuCgNGBAct5156bBL0syT3dOXD6ebByyPNQHji5Ey0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaoCh6XWRWjHpAXKdoDb/xUELYwO+sl3E2X+Nt9NLHs=;
 b=IBbcWYlPQDybzaoy2TM4KHtev6wr5+zfg/H51dlO0xzEn86KLUmRFLzSLuN5OWYrLItxMg2RfmbRX9xc2nC/jsYYiG5jhskONBhJXUVK+SS1GNzUV1rnBP3MoMcMzJldSu2dn3mqd89GV+EUh5c3AGepvyJO2RZGMrhvCblvwDf5imwFRsiW+cfnVWvQDw/w+DBfGG3+3OAZa5P2N8xUQtKL0qKvVD9y9iQVV1DYjntZwsZjv807s0xGwOe9WFyQulu5abXUSMCFjoHiUW+/PL47/Vg+88vwGhvaCATawZ9BCaCNHjifDRzTNCNhByuETPUopfLETBQ3kqVED6FWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaoCh6XWRWjHpAXKdoDb/xUELYwO+sl3E2X+Nt9NLHs=;
 b=GZ/E9BnVncwx7owfWxhYLCoblhyM5wYtOt5FDhP3vic5OVAKXhS3xFLgD8OvQVgbPJP8Oua3ZtmJYwx1pCo/umfjS0z6sLsMO6mOIRVVVLiX0jxyyreWpbIXjxtqfyX02i2EIG7y9XipSh8yA2axSs9Tc1o96Jna8uQyIsu5Aag=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DM4PR21MB3781.namprd21.prod.outlook.com (2603:10b6:8:a1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.2; Fri, 12 Sep 2025 20:47:15 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:47:15 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Chris Oo
	<cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 09/10] x86/hyperv/vtl: Mark the wakeup
 mailbox page as private
Thread-Topic: [EXTERNAL] [PATCH v5 09/10] x86/hyperv/vtl: Mark the wakeup
 mailbox page as private
Thread-Index: AQHb592yUzU2jTd+/kOwA4ZSTgMpmbSQfP3w
Date: Fri, 12 Sep 2025 20:47:15 +0000
Message-ID:
 <DS3PR21MB58782125C2F0EF520E6983D9BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-9-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-9-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2afbd8e-475e-4837-bf8b-bd63da37a92b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:46:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DM4PR21MB3781:EE_
x-ms-office365-filtering-correlation-id: dcdb342e-5d8e-44e4-475a-08ddf23d8e6a
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE41WmVrdWw1UkpmaXFwNkVHdFJkR3RwRHlXZVVweGFLN3RraGhQTlVrb1lN?=
 =?utf-8?B?dnJhaFd4SXNRRTV6ZTVBM3pZYnQwUHFETDI5M09XQWQyZmpyVTc5VkF2V1Q5?=
 =?utf-8?B?QjZ0Ty8yTVpMZVN5UkM1TGlOdnk3Tms4UmUwTnVOR3dXUjh0Wmh3eE5zK1hD?=
 =?utf-8?B?bEwzbVk5THg1UlB4M0k2ZWpURk9zaDJnREpwRzF3SVRoaVUyTFdpZU9NOXFv?=
 =?utf-8?B?ZWo3c1RyaWVzenR3UzJUTE9FWEZKRmRWYnhxQ0QwUUpXMWhwVW5XRlF6Rmd2?=
 =?utf-8?B?WDR3cHR4TzNiUXlnOVg2VzZjcTl6czRnRmRoV2xvMEpib1lpZ1N2NW9BczNq?=
 =?utf-8?B?V1dtRzBmcVF3cys0YlF0N0lxT082cWZzcHk4TU9lbjlXN2ZGQkx2NEM3aDN1?=
 =?utf-8?B?Wm5iY3ljOE5Ed1pYOGd0ci9VVFBOb1hHMVI3ajRMUnhOZkF6dVZPRkpDdlk5?=
 =?utf-8?B?VVlzTmZJaGdaVGpMWVFYblhLUllKUkt6QVp3VHJocEVjU0l3OXQrU0ZwZUN4?=
 =?utf-8?B?RE14WHhZNTNpejRFVWNQMXRkckZWZm9IYWthMXZKc29ZK1htYzByTy9leExi?=
 =?utf-8?B?d2hxV0d2dm91U1Z3dGhKb0VxUmJpcko4akFiNFRLTi9HdTM3SXI1T0V5VXdn?=
 =?utf-8?B?ZitHUVhPaG1Zbjh1NDZjQWJoQW5XRVN6blc0UUdHUGpaZlRrZjFlYWdnT1JF?=
 =?utf-8?B?cmZjdDhyL1NJSHJBbjZEc0tNVWdoN1pJb3A0clBXbjF6K05sUEpHclU1dFB2?=
 =?utf-8?B?Ymc0M3VwRkE1OU10ait0RElHcGN3TWp2WEpFUVRkV0doYmNuUXdmYTFrdzRw?=
 =?utf-8?B?cENIY1VRTUpha2xwNzZ6ZW1NellHMlBDSVpTN09MWmJqYWx3SmFJYWFVSXNq?=
 =?utf-8?B?Vk5Samp2OHl5K2NFV293dzkwc1NQcmFQSHVjSEdGVFFGNHFHdXpMSXBHQmFG?=
 =?utf-8?B?MkNnUXpCTWZPMnU4WUVEdm53THpXVjRHYlROQVdZU1orcG44dENwWWl0NEEy?=
 =?utf-8?B?OHNiMU83Y1l1RDMxLzducnE0M3p1S3J3VUcyMXI2RlRqODIyYTVrVFE1dGVF?=
 =?utf-8?B?TW9YVGI3VEhCdkhqMVdSMkhReUhobmNERXgrT2M3dVVBWlRGeGZZZHRQSTZK?=
 =?utf-8?B?bCtDUGR6Q0c1bEwxdk9NUHdIYzR0ZHB2YVRtUkhFcXZOczlCVWt1akhPL2x6?=
 =?utf-8?B?eVRNT2xneDVYZzJXbTYrTXJzQ3ZIaVZtcG1ONGJqd2tONmw0WXpNeVNWNjBi?=
 =?utf-8?B?U1lYbHRGdTJhU1duQTF1c1FUdWo5ZTdmUnRJdVNLV0xjMklYc3hWNU1iVmZM?=
 =?utf-8?B?WHFEc2Z0VkZpWGZSd0xLSm5MNUVySTQyd0UyR0E5dUhiRkgyNXJQUkJMZC9J?=
 =?utf-8?B?ZzhjWTlwbTdmSmtyOHRidDRPemRtdkpHR01sWTRFL2VLYjJaQ2tQWlg2ejRW?=
 =?utf-8?B?U3ZUWHdRQVoxMDJSV09RMXl6SjZGUVNGa0xzWTZYR2Z0b1I3RUg5S1MzN2FN?=
 =?utf-8?B?c1pucVpwakdKVDJBc2drZkZUbFhhMDVNK0N4YTVaQWo0dTRsZHcxWkRtSUNM?=
 =?utf-8?B?M0Vkc2N3OUkwR0NveUtkcEFsODNxblBmNnV5WVhaT2FmeUNsZFRHalRxU05h?=
 =?utf-8?B?TGxpclM1QnUrNE1sQWZpVE90ZHBjMmhHcFpQTWhrOTdXTU0vWlQ5MmlFdWxu?=
 =?utf-8?B?TmF6c045enh2WHJ4QXBaV3ZiUGxveUVlRXBKRkFrcTVPTDB3dGZWRVcwd1Q3?=
 =?utf-8?B?QkFPVG1INEZaZGlKR2ZXNlRjTGlOVzJvUEVCM1FGVlZ2NDhlOFNMY2docmNh?=
 =?utf-8?B?YlJQZElIOGF4cmNlcit2UFVUN2FlWm12YWR3WW5MK1VOU1hQUGhDdWFQcHVm?=
 =?utf-8?B?eTNMMzZoL3JJS0pjWmpybWVPQkY0MmNMS25BTExEeVp1ZjVpd0JOOS82U3Zq?=
 =?utf-8?B?ODFQV2ZqOGVpWE9jSjQ3SjluNTZMUFJMQWFzemk5N3NTS3Y0MGF5OU9XTXRH?=
 =?utf-8?Q?srzpIj+llaSBA5TdDrQ2f6usnPIgXo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEFZV0J4KzdSTTF5UzFZT1gzNXdLSEZiMnE2YndjRUs5YzNyV3l2czlGYW13?=
 =?utf-8?B?LzE2WEIxVUdMVGQ5bUVvVTlWaTdGYUVIYUtTUVhEb29NenArVEd3MVZXUmN3?=
 =?utf-8?B?WTA2UDdQNkNtcFVBby82aklad00xcWdpc3BWYTFiUUk4aEExeDltcncxWEd5?=
 =?utf-8?B?cG5nMnBJRmpZV0FIRzRsQ1o5YTdNc0FLczFtazdWeUphMUdxSklucmdpWitW?=
 =?utf-8?B?b3BwZDV2ME9UdGdQclZDSE5sV1UxZWZka29NSEdoaW5BakN4TTNQRFVuc2pi?=
 =?utf-8?B?Q3M5Qy9ldkNadXdxV0hHMk5TYkc4dWozZDdIRnhXSXZtQTBlQ2ZrWWVINTFP?=
 =?utf-8?B?N01iNkVKaXJFM3hhQXZyby80S3JTSWZubzZlUU9kUkNtUEtnQlhoZHgrQTNB?=
 =?utf-8?B?T1lGdENZcjlRV084enQwT3hWVmxOb1hFcWpzV001YjhSaUw4VjR6Y2NFaFZ4?=
 =?utf-8?B?dXJETUExeUc5MnhKS1hhZkV2UW5BZTZ1VGFpV2wvWm4yMVVXVmQvZ1dWc0sr?=
 =?utf-8?B?VTg1bDdySWZ3WHNDYUU1RG9LSWJKTHl4V2VkbHpKSFNDWHpFYmlUVUxrdjRD?=
 =?utf-8?B?WG9FQlRxSFZOeTJ6dUFhRWN1UG9XV2RxVWI0SnZwakF1OXhsc3ZjK3JmaHpr?=
 =?utf-8?B?QUFiczB0bjNUelpKTGphRnQ1cnI1emJTenRqUWo2M216d2puakRNREJ6cVF0?=
 =?utf-8?B?c0dTODRjRTRNQUovMXA0WXlvREkwMFJZZG1DQ0x5WWt4dU00bUtRTzM4enhJ?=
 =?utf-8?B?YjQ0ZFBVOHBjQmFNeHhQUkozK2ZKSUVNckhKZk9zMThWdDZldk8xeEM1YWFk?=
 =?utf-8?B?aVVFNnNkV0Z4cmNCZ0toZllhQ1dzUUFEb3dRWFAxZlRWeTd0a3RXQnUwcXE2?=
 =?utf-8?B?RDlQZGFpTzJyZE1WOG1tdzhNK1cxNVR3eVJudlI2Mml3a2tBWnpreGp2V0VL?=
 =?utf-8?B?VndnRzhvYXFDRjhoT1lRZFQrV01kOCtJZytrQzh4UWlsRk1kcmEva3BhUW9i?=
 =?utf-8?B?NUhYQTJhSnRlelY4R0NldEhyS1FtWFcyNDN4aWVjb3FrY3Zqa3pzbUtnL1dC?=
 =?utf-8?B?QWhvRUtKUlMyRzhPb2k3Z1BEZGZoclh2Wmo5aFNCbHluRzVjdi8vL2ZXQWhS?=
 =?utf-8?B?dWxqeVNoNmFmZFdtOTZabWdlemFDeUtFWXcxejIzaUxqK3Qwa1p4Wm1KNTRT?=
 =?utf-8?B?UURmakZicDhzSEYzSUdXMEZlNWp3Y3REZHlad0NSNGlzQ1MwWVU2ZElMQmRI?=
 =?utf-8?B?TEd5dEJVUVF3MWovbWI5WHhzR3lXbk1Ub21ic052Wm9sVmdCbzVOWnkvTFk0?=
 =?utf-8?B?Rit2dnI4a0t3dlZiV04zVlZ0TjNrT0xMdVdxT1R6YXdjZlVLblVqSURBZUM3?=
 =?utf-8?B?ajBnamdwWUFKd29zRXRLUUdwbjhQWTk2emJuRE41dVkyRGlyUG04UnhxSkMv?=
 =?utf-8?B?VU04Rit0MXRsdmVMSlFVZzV4ZTRJa2ExblN5TUdxek83bHJldTM1akNuMXNh?=
 =?utf-8?B?LytRa0NlOVcvZUxsS010eXk3bXFUandqNWJpcE56YWVtbitrTWdxK2tYbk9a?=
 =?utf-8?B?amNCU1NLRmNHdmtTUlN5eWJFV3dnVGFMNVR4WklocXdJMXlieEFRMC8rOGY3?=
 =?utf-8?B?aHM0cWVGWUwzclFJYXNFNmdaZVdVc01ST3RQRUlhZjJycjZnWWlqN1NEbTUr?=
 =?utf-8?B?YzV3dHJRbkJWVDNUb1pHYU9zaXNGTDlaTW9lRTA2OEhGZTlqSHJzV0VlWmkw?=
 =?utf-8?B?STFSTUJOZWYxL1NVRlN1RHBYRkZEYVRJZ3Q1aE94WUtORXNSSVoxNjFvWkxX?=
 =?utf-8?B?SmNXKzYzL3dURTBQZW1NRlhqdjM1RC9JTzJEMUpxdVY4eVBDcFJjSFlwYnNT?=
 =?utf-8?B?RDlJbU9uMk1Ia05WeUtyYkNNbHhQdUVqUW90Z0d4b1BNUy9HNUVxNS9EVFJ0?=
 =?utf-8?B?cEVpT0hNTkVHUDVIdFlrWXpyMFJSUXdOS3BIb2N6Z0RCM0l2QVBNU0dvU2Zy?=
 =?utf-8?B?Skk5MHN3VVlQOHA0SXJ5ZFZPVGZEWUNSemJKUUl5RzlDaHNZQlBmUk4xdVJw?=
 =?utf-8?B?Z3p5VEh5b1pSSkFSblJ5N2g0VkVqT0lsdDBLTkFyNlJ6T2RpMGR5ZkMvU2da?=
 =?utf-8?B?K3BURUJ6QjhrQTlZQTlPTFQ5elpZWjU4VlVRaExxMUJhUHlwa3k0ZnJIaW50?=
 =?utf-8?Q?3xfGyxCxCXsvabb/2LzC7HE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdb342e-5d8e-44e4-475a-08ddf23d8e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:47:15.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic7/DCvvcvcmDzKnXAbr2swrMR5USjmf9rBXM7AIgh1QmH4Zn9pveuXjfSgy3bRY+yqP1dBM2T3dz8IqID9lfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3781

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IA0K
PiBGcm9tOiBZdW5ob25nIEppYW5nIDx5dW5ob25nLmppYW5nQGxpbnV4LmludGVsLmNvbT4NCj4g
DQo+IFRoZSBjdXJyZW50IGNvZGUgbWFwcyBNTUlPIGRldmljZXMgYXMgc2hhcmVkIChkZWNyeXB0
ZWQpIGJ5IGRlZmF1bHQgaW4gYQ0KPiBjb25maWRlbnRpYWwgY29tcHV0aW5nIFZNLg0KPiANCj4g
SW4gYSBURFggZW52aXJvbm1lbnQsIHNlY29uZGFyeSBDUFVzIGFyZSBib290ZWQgdXNpbmcgdGhl
IE11bHRpcHJvY2Vzc29yDQo+IFdha2V1cCBTdHJ1Y3R1cmUgZGVmaW5lZCBpbiB0aGUgQUNQSSBz
cGVjaWZpY2F0aW9uLiBUaGUgdmlydHVhbCBmaXJtd2FyZQ0KPiBhbmQgdGhlIG9wZXJhdGluZyBz
eXN0ZW0gZnVuY3Rpb24gaW4gdGhlIGd1ZXN0IGNvbnRleHQsIHdpdGhvdXQNCj4gaW50ZXJ2ZW50
aW9uIGZyb20gdGhlIFZNTS4gTWFwIHRoZSBwaHlzaWNhbCBtZW1vcnkgb2YgdGhlIG1haWxib3gg
YXMNCj4gcHJpdmF0ZS4gVXNlIHRoZSBpc19wcml2YXRlX21taW8oKSBjYWxsYmFjay4NCj4gDQo+
IFJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFl1bmhvbmcgSmlhbmcgPHl1bmhvbmcuamlhbmdAbGludXguaW50ZWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBs
aW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KDQpMR1RNDQoNClJldmlld2VkLWJ5OiBEZXh1YW4gQ3Vp
IDxkZWN1aUBtaWNyb3NvZnQuY29tPg0K

