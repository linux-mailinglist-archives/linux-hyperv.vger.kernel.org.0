Return-Path: <linux-hyperv+bounces-7719-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C044AC7635B
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 21:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1603F4E2EDC
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF4F3624DD;
	Thu, 20 Nov 2025 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GgZ5LoiI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020089.outbound.protection.outlook.com [52.101.61.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0C306B35;
	Thu, 20 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670746; cv=fail; b=bub8FSeJe6PU3v5pGzcfT/N3X1Iz1ZqTAuwX91mmIUtnRstfEanGe3wix0M3QMK5E87NBs2RNedxZmpSiINEfOarQUd7chAwPzwSU+05iZ03sYeqyVfAcGI7FmWWq7tsjVnLBag0yV/hDKjVIT65HZysfJE53aZG+mnZ1W0AKA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670746; c=relaxed/simple;
	bh=VpeSE5u4RguP1ojQ9GPyZBRYaUBfNI6M8cm3U6SKRWw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ic3Zi+MTeRCRiQP4AXP/AKbxH1+nRt9FIz7rfO4CNefXiFz2kltpnpjylZHSe6rNq2pirU30d3W3hlxo9d9nkcT1qRWPUHVqehY3RU7hcpngU1oLQV4TgbMCsV0ofnRCTqytL2ymP+2ke/KEWxV9Aa9IeWxjxFy4vhqI2oO80Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GgZ5LoiI; arc=fail smtp.client-ip=52.101.61.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxD1Y5i+vNboTdIdzYOBT4eNHf8qlkynJ1FNqfWLsZ8BtOeSgQxkBGO6sVlkSFZbddUIhSgfKub70a+oAS8XWtjETQtbMcoWenCerXmlLkercBM3ZhUJHd4/8XSRCF8uIIT9gQiNK/CxExXX8ILly4yk7dWg6wklflVMDJqvHipb13/13ge/h/BaxtIN2EghxnlSGv0fd/L2Yzl6UfWx1FLFD7tVXKoMsZ5ArNH/KHDLowv/ZKFFut1D4drIXXc655RzdpSZN5K0THbaNFgTeyC/Ief2qeMV14HBz6aV18tdYtGOtojbVWkA303gKdmahg1jX3w+Z+LI60kruhzw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpeSE5u4RguP1ojQ9GPyZBRYaUBfNI6M8cm3U6SKRWw=;
 b=U+hf9cuGvgDIEgSiNfMj6mXMR55Udoy6L741A7jUypg3/77j8h3NLJEnhVkxIkdUGMPLOwM9FYbAbLFqWulvFAhs1DPmK0FjJdQZ+/EfrwbXxs80h6D757438B2u0HaFS8XGEoHn23N3okHXm0kebJhSs2MF1OmmEGEjYzSbsH1+6Bwa8OLKNfgxRnF3TA+FjhxO/G2dkOylj/NvrrSLI8s/X9spBBEM1tXVtdkmfanNnbapEP1E/FasUOB0Ws5B7FbIIqE2APm4fbCnit/OWoh9wpshgxX66RLeuQtexeLuJytyL9v0qOMsGt7R1CcSrUlSeoFTLgpfBl3HHh2ADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpeSE5u4RguP1ojQ9GPyZBRYaUBfNI6M8cm3U6SKRWw=;
 b=GgZ5LoiIg1fiorwRCI0Lu8yDmpzHX0Gg1EslwaFgMk+Z1+bKIIVDCQXFHXMCaUcTWAY9cXzfp5WwntJPT/cB4HBYdwW7Zyjsq96eT57wmM09j46LPyYENYVcZohzan523y5btKv43Zcww4293Lx5YyCwWAb1/eeGwpP8aSrawRc=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB5931.namprd21.prod.outlook.com (2603:10b6:8:2f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:32:20 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%6]) with mapi id 15.20.9366.002; Thu, 20 Nov 2025
 20:32:20 +0000
From: Long Li <longli@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch net-next v2] net: mana: Handle hardware
 recovery events when probing the device
Thread-Topic: [EXTERNAL] Re: [Patch net-next v2] net: mana: Handle hardware
 recovery events when probing the device
Thread-Index: AQHcWC33+/L/oNtrBECT7NfUsCDxALT7bHGAgACaK5A=
Date: Thu, 20 Nov 2025 20:32:20 +0000
Message-ID:
 <DS3PR21MB5735D041BB553CE620C68443CED4A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
 <7d835eb1-f111-46e5-8834-a1fafb53bd8f@redhat.com>
In-Reply-To: <7d835eb1-f111-46e5-8834-a1fafb53bd8f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c88e558-c631-4778-9c39-8597d34e0629;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-20T20:23:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB5931:EE_
x-ms-office365-filtering-correlation-id: 8970ab4d-be02-4334-0218-08de2873e784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1ZSclpMR0FpNjlrNkdNaGxFd0tUdTFJd2FnTUh4d2QxblhXNitla0hsWG5C?=
 =?utf-8?B?c3ZJNmFjTGpGVStRcEZKaVd2ZVlIM1MrN1VkbFlUYlZtbGwvNmo5clJvSnpu?=
 =?utf-8?B?VG9jaitVTTRidXNWWkxkaE1JYnl5bkFINVpKZUhIOWx0THRYcnVqS3VraWFP?=
 =?utf-8?B?MjBvcjY5eHplYjFNbld0eHhaYU5VL0tWQ0N5cStwOEFEb2FkMXJZZ0pCZUlP?=
 =?utf-8?B?YWVsT003MWlmOUorbU5ReVZBaU5MOGg2NTRWVDJadW95V21kcHRhRGlDcm5C?=
 =?utf-8?B?UUttaTE1SkZJRXdIcW1IRWlEcUV2Sm9lMGtENlZnam52b09hMC96WkRBSkor?=
 =?utf-8?B?WnUyWkVBYzV6QWdIM1hkWTFUMHFSTzhjZG5qU3hYZCt4WURWVGFrK3dwMitD?=
 =?utf-8?B?NGdac0dKeU5uUnMvdzQ1SVVWZ2pPRFlLb254YVYzODVKVUoyeVIwNHR6djRh?=
 =?utf-8?B?cXVINUVhaTVETXkvWFdnRWhuUERGNkhXTTM3OGlyQUNjMnFVNGhTUDlqQ1VC?=
 =?utf-8?B?TzV4TXowcFZlS3htNFpZa0JQWWcvRVR5Zk0yNyt2WDdKSnZzakFYdzVNVVky?=
 =?utf-8?B?bGZxYno0L3hINDFlZ09oVERLWXE5OXNuZ0lGNzgvYkRyL3VBUzBORm5VelJn?=
 =?utf-8?B?ejZ2cFR2ZG5zRjBYUllZZ0s1MlBCaUNMKzRXTmFhc0RsekkyandsQ1FFRFlt?=
 =?utf-8?B?NmZJNUtBaDdPRWhkMHNaOWRJL1YxeGMzUytwTVVKaEtBWGxOU0lDcmJ5ekRN?=
 =?utf-8?B?aVNvWmIxUTltSlhLZ3B0Uy8yOTA4TEZ6THRyakhneHVQWWRKMDNnd29nendw?=
 =?utf-8?B?QWlmalBFZzE0R2t1ZUh2STVzc1VXb2t1WlZvQUhIVkhIUTNlZHhFSmswQ2tH?=
 =?utf-8?B?ZzR3SWEwMHl6SWduMDRmSjVlMFlyMUg5QWpGTFM0Rm5NNTRBZnBFTngyUzhl?=
 =?utf-8?B?VWRTeDF6SGQ4S3ZvclowRzZkbDFOdlJ2VmNWWHJZR2p6ZnR0S24ybHBzTE9o?=
 =?utf-8?B?aHJWZFV4MFRsZ25TZGE4TVNwVC9odmJweHIxNktIK3BCQ0h3WVl3WWkxa0cw?=
 =?utf-8?B?NnZUbFZHRFQ2YmtDaEtIdDRnRE93YjVzazY2VERkeHoyZkt2dmg1MEZhdzR6?=
 =?utf-8?B?WkVWSlI4UGRtQTRPSVhaaFVVVStqUDBmejFSV2xqMklKN25SYUFwZSs1SGFw?=
 =?utf-8?B?clorVzE5VDZ1N09aeUhhc3ZpVmd2c2JvYzJUODREcjhUQkpQU0UyOE1ybzl1?=
 =?utf-8?B?NFVFV2V0NXQvbG9kNEZQU2Q4cUJqNHBMaU0xOTBROFprZ0dBU1B1TGoxWnQ3?=
 =?utf-8?B?RjZ6RjMrUVNRMDBPVTJ5Z1VselpCR2YrNUdadmwxMUl2N3BQWXdXMjg2SDg0?=
 =?utf-8?B?ZWdGSm1sK1dGZVFJa212TnJXZ3VNbms1OVhHaGQrbUxleEZzaU5qa0FCWWk1?=
 =?utf-8?B?SSs4L1NhQVRkNWhHOTlCRTdIRGpkMUFJRURHQlY4S3VuT0phL1NTSVpuOXhn?=
 =?utf-8?B?RlB4dWNlTUVsUitFUjR3YzBmZ00xOWszN3JrU2NpZmUyYlQyUUFsUDZVSVhq?=
 =?utf-8?B?M0dkczFvYzVCalNiNzNnb0c5TkpGMTZCOWd6SEsvOTE0eDFRcTF6b3Bsbm5H?=
 =?utf-8?B?ZW4zU3pKcnhMMDU4d3N0bmNRL0RwaktiOWNlVXlGU0xmQWhobE1kdGVkd0V1?=
 =?utf-8?B?Q3ZMeXArNmM3WEJaM2RXL1B6clAyb1pTV1hFL0tVQStTK3NZaW5jVk82eGg0?=
 =?utf-8?B?MkNqNVpSRVV1WnRFUis0cTBLdGhvY3JIay9OamkwREdPbGRjWlliL3dOZ1pG?=
 =?utf-8?B?TFZ6RFgzbE9xdkJGRTVyYUs2TDE0czNPTzUzL1dZSTk5Y051ZXdIMlVQdGRn?=
 =?utf-8?B?alltSTZKT2o2eng4UzVwUUJFL3I2czA1WmQ5MWpwMDl4M2xoL2haRTlhUm83?=
 =?utf-8?B?OHJFS0RDd2xYYk8rRmllVmIwY2wzUkljdnZIVkNIYzZJVFQ2QTluK3Iwa1JK?=
 =?utf-8?B?c1g5eStFZnhhK3hMWm9iWkNIOWlSTWxjR3ZQc2hNdEh4aWhYby9xcEo5MVRT?=
 =?utf-8?B?dkRrS2s1RWM2L3hxVHkrSkt6cjJjQmV6aTZBUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0w2bGdka0hMT2RVNkw4TENLOHIyeWVLeHJERTVZU01SMmk0QkxOYWQzb0dl?=
 =?utf-8?B?V0dpcEdRMHBKWjFwVkx1ZGNxOHRBTUxaaXVGMi92ZFhQcktiRnNlOTE1d2NM?=
 =?utf-8?B?YnNLOHBxQjd5eXBXUU8reDNnTXpNVkVCMXJ6YlNyaXZ0SFlDUk5GK3BjVHBS?=
 =?utf-8?B?U0dHR3FrTEVqdWg2TGJRTFpzaEkvWVlJSFhxcjU3bXhwaFVrVU1ObTErVVhV?=
 =?utf-8?B?VjZha25XTkNhbE5UQlZWejVLV0lOdEthNnV0ZDdCdXl4TWU4cUtHQnp6aUNn?=
 =?utf-8?B?Z2RvMGdQVHV4VVg1SXdGUXYyWGxldHA0UkcxZjRFM2U3VkNxYXR5UGhDMXB6?=
 =?utf-8?B?VExPelZZRzhZM0xncnd6cmIyQnBzUVR5L2xmVTNOL3NwWlBwSGhubGlRQkNv?=
 =?utf-8?B?Qjh3amE4V1VmZlo0UEVxOGdqMW1FTlVBUlR3TEdSaGRjcit6Y3RYT21WNHA5?=
 =?utf-8?B?V3FSeUt2c0hTVldKUjBwK2ZtWmxQRTZjUi8xMDY4RGxkQ0x4MnlGSmRQeStG?=
 =?utf-8?B?R3FGMldLcFlaNnh5eVZpTktWL0haT1lHNUk1MWVieUlRY3o2MDV3Y1BlOUs4?=
 =?utf-8?B?TjdVZ3JBT0dXNlVybHYzWEYyeW5vTUM3RHhhakUxUjEvV2s0L1IvYmEwbTJo?=
 =?utf-8?B?QW9Dc2pxcjVvaGczNEdabEdiK29ZdmRWZUVJTnBMeUg5OEVoSXV3NjlMRlRD?=
 =?utf-8?B?bmlJdXVROXgxaGFJOEFJbDFXTUROZnZEMWJGcmMyVDl3OWp3R3lPWGdBQysv?=
 =?utf-8?B?KzQwbjZZa0F5Sml4VmkyOEhJeW83NGIzZEpUb3lyYTZwRkZwRWpNUWwxTTYv?=
 =?utf-8?B?cGx1b0JvV1prZmNiaXFtTXhLNXd1TXNiOE9qOVYyeUcweXpyWEI1K0lYODA4?=
 =?utf-8?B?dzhnQnJvbE5YRzBtUE5YUUdyVU1SVXV3dVB2OFZhSHpVUVFzYVFRWjZXb1Ez?=
 =?utf-8?B?ZDN5d2g2bGNuVDNuSndCZ2lMVmVROHQ2OUVaZnpUL3BTNnlDZ3Mzcjhhc0hz?=
 =?utf-8?B?QllqQXlvMENrQzR3UDg5UlNpVlM5UU41N2l5b0IvSEt6STlvWndzTWoyeFZs?=
 =?utf-8?B?TlpiMS91MVRveVMreWJmMUJVaUJXU050WVp5UklqTVZ3amtDQmg0aWlWWjNR?=
 =?utf-8?B?bktGSDYvbldIQWV1L2YrRStNYXN2a0tzV2RDT1hZQXdQN1pacDZzc2ZtWEdY?=
 =?utf-8?B?MW5zMXUxeW5xb3QwK0RIaE1HOVZNQVVpeXRaNDQ0dGNNRHJlVjlNT05YdEJt?=
 =?utf-8?B?dG9Xb2dPWDMwTVI1NGtMVVE0alpRUS9zOHpDWStVb3BBWWlsVS83OVdXY2Jr?=
 =?utf-8?B?NVpDRTZ6UVNzblNuOTdxOUt6Y09jcW9ETmw5c05Ybi92bnNITkEvczk0clFI?=
 =?utf-8?B?aTUrbkJaelNXV3ROcG0veTNlQ0NkQU16NnR5Q0VkdURYaVZJR3hsN1o1L09o?=
 =?utf-8?B?S1ZrNEJ5ZU1hYmU5Nmh6WXhPMGdsdUxJVXFxbDI1RnloVzRyZng3V052MDcz?=
 =?utf-8?B?LytCa3AvSjhKNHM2L3hWSlQ5YmZpTW5pQ2hCMHhVc2FlL2Rya0NjNWVGZnZJ?=
 =?utf-8?B?bDVOUkJQSHdDU2Y2cnJzSEJrVWlVRzRQTEJZV1JheUZEb2ljRDN4cnYzZkZD?=
 =?utf-8?B?Q0g4M1p5dUo5NWVUUlJlcnNHY2lPaTd4ZXExb291dVUyR29VN0EzNG5QaVFQ?=
 =?utf-8?B?MEZSZFNIdlNKWjYrV0Q0bldBbGdFWWV1SDRmTVNCN3RlUXFEQUpSRnVDRFBj?=
 =?utf-8?B?ZEdadUJGUXlqL3NRZFJ0R093ZkNWOXB0MUVqUmlZMXNNS2NuY0FnaldFL3R5?=
 =?utf-8?B?bDlHV3NCcFpmUGd3NVpRRVN2d3dvYnN1MnEyRWMyQkQwcU5xbzlhSkdmTE1p?=
 =?utf-8?B?SDBTR0pFSXl6Q3V1T1lZbkpPRVA0bDQvUTAyWkxyN1pnclJxTGY1d2ZZZHl6?=
 =?utf-8?B?Q3hEQ0V6SythWmMwVHRHbUN5WndSbTRQeU1WSFU4VnUweW1oam16d0RkTmU0?=
 =?utf-8?B?YW45dlJGNnZ4NGgyb2RsTENCY3NWcy9xT3pzYVY4MGViZkxSVDRORytDb1cr?=
 =?utf-8?B?UkwrYndtS3hmbWJFd0ZHQlAvOXRkYUxDK3dZTWplNVhOdTI4eWhheHpqUFZs?=
 =?utf-8?Q?zkeg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8970ab4d-be02-4334-0218-08de2873e784
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 20:32:20.3673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwbIgIFDiCxHTbqo1P/WiUew7jcQ6w5I+k8Xw+cVPpHgrPecqVhTOwdTKI+e3dqJDMb0wX4KedA/Q8eTR08s8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB5931

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUGF0Y2ggbmV0LW5leHQgdjJdIG5ldDogbWFuYTog
SGFuZGxlIGhhcmR3YXJlDQo+IHJlY292ZXJ5IGV2ZW50cyB3aGVuIHByb2JpbmcgdGhlIGRldmlj
ZQ0KPiANCj4gT24gMTEvMTgvMjUgMjo1MiBBTSwgbG9uZ2xpQGxpbnV4Lm1pY3Jvc29mdC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4g
PiBXaGVuIE1BTkEgaXMgYmVpbmcgcHJvYmVkLCBpdCdzIHBvc3NpYmxlIHRoYXQgaGFyZHdhcmUg
aXMgaW4gcmVjb3ZlcnkNCj4gPiBtb2RlIGFuZCB0aGUgZGV2aWNlIG1heSBnZXQgR0RNQV9FUUVf
SFdDX1JFU0VUX1JFUVVFU1Qgb3ZlciBIV0MNCj4gaW4gdGhlDQo+ID4gbWlkZGxlIG9mIHRoZSBw
cm9iZS4gRGV0ZWN0IHN1Y2ggY29uZGl0aW9uIGFuZCBnbyB0aHJvdWdoIHRoZSByZWNvdmVyeQ0K
PiA+IHNlcnZpY2UgcHJvY2VkdXJlLg0KPiA+DQo+ID4gRml4ZXM6IGZiZTM0NmNlOWQ2MiAoIm5l
dDogbWFuYTogSGFuZGxlIFJlc2V0IFJlcXVlc3QgZnJvbSBNQU5BIE5JQyIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+IA0KPiBEb2VzIG5vdCBh
cHBseSBjbGVhbmx5IGFueW1vcmUgZHVlIHRvIGNvbW1pdA0KPiA5MzRmYTk0M2I1Mzc5NTMzOTQ4
NmNjMDAyNmIzYWI3YWQzOWRjNjAwLCBwbGVhc2UgcmViYXNlIGFuZCByZXBvc3QuDQoNCkkgd2ls
bCByZWJhc2UgYW5kIHJlcG9zdCB2My4NCg0KPiANCj4gPiArc3RhdGljIHZvaWQgbWFuYV9yZWNv
dmVyeV9kZWxheWVkX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0ICp3KSB7DQo+ID4gKwlzdHJ1Y3Qg
bWFuYV9kZXZfcmVjb3Zlcnlfd29yayAqd29yazsNCj4gPiArCXN0cnVjdCBtYW5hX2Rldl9yZWNv
dmVyeSAqZGV2LCAqdG1wOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArDQo+ID4g
Kwl3b3JrID0gY29udGFpbmVyX29mKHcsIHN0cnVjdCBtYW5hX2Rldl9yZWNvdmVyeV93b3JrLCB3
b3JrLndvcmspOw0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZ3b3JrLT5sb2NrLCBm
bGFncyk7DQo+ID4gKw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGRldiwgdG1wLCAm
d29yay0+ZGV2X2xpc3QsIGxpc3QpIHsNCj4gPiArCQlsaXN0X2RlbCgmZGV2LT5saXN0KTsNCj4g
DQo+IE1pbm9yIG5pdDogaGVyZSBhbmQgaW4gc2ltaWxhciBjb2RlIGJlbG93IEkgZmluZCBzbGln
bHkgbW9yZSByZWFkYWJsZSBzb21ldGhpbmcNCj4gYWxpa2U6DQo+IA0KPiAJd2hpbGUgKCFsaXN0
X2VtcHR5KCZ3b3JrLT5kZXZfbGlzdCkpIHsNCj4gCQlkZXYgPSBsaXN0X2ZpcnN0X2VudHJ5KCZ3
b3JrLT5kZXZfbGlzdCk7DQo+IAkJbGlzdF9kZWwoZGV2KTsNCj4gCQkvLy4uLg0KPiANCj4gYXMg
aXQncyBtb3JlIGNsZWFyIHRoYXQgcmVsZWFzaW5nIHRoZSBsb2NrIHdpbGwgbm90IGNhdXNlcyBy
YWNlcywgYnV0IG5vIHN0cm9uZw0KPiBvcGluaW9uIGFnYWluc3QgdGhlIGN1cnJlbnQgc3R5bGUu
DQo+IA0KPiAvUA0KPiANCj4gL1ANCg0KVGhpcyBpcyBiZXR0ZXIsIHdpbGwgY2hhbmdlIHRvIHVz
ZSB3aGlsZSghbGlzdF9lbXB0eSgpKSBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQpUaGFuayB5b3UsDQpM
b25nDQo=

