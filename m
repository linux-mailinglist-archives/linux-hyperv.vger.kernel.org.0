Return-Path: <linux-hyperv+bounces-6845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0664B557C6
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D7FAA7D6F
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E32C236B;
	Fri, 12 Sep 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XZFT7L43"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334C2DC76D;
	Fri, 12 Sep 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709831; cv=fail; b=PJ8LwZZJLttebSRmWuzoBf1kFCawgrZytXSJBLNJecai32sSPxi7Ih1VYFFnJWmNXmJ+AfJV7vpFtpjhwoxwm6o5jdv+fzwB3mTxHOTuopGclvn2s9GxwTaHaCo7rgrsES53OoybAe0AiKgc5dczbBkuc+wEMiHRLOPWun2GDXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709831; c=relaxed/simple;
	bh=83gsPCeFvRHq/Iv/LxFKBJAl3DKn6KSlfcJbhzQwLpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tWgQ6Wkzi8h9qzuqm+gbCgTD5Xk2s2dyDmTbz71gQUfjXOjpb3exu5NnX/0doGw3ECMk32Zq3fox6L/U+rg2As90UBPcXXgFB9cshcdb5DevOH5LGoXiL3sU7srCygbg+p6HkCLZt4q68hfdmDWgoVgQ5UdgUS3f1w7oPe/SVr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XZFT7L43; arc=fail smtp.client-ip=40.107.223.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT/NLziZkeE/elOkFAy0fSlgN++tUnzq9Prf14iboPQ+xmgzGis7MLN1el27Q7pK0tnZrNhtwRL1gD2Qipsrk5YUf+q6OQFhKtNxFBMJw+YxR2mFOiS1kYwTeiQhmiJtRr5mhxwC/cO5a3XmCnGPWJyORi+WJjitX5vlGQ/LCd6Zsn11mis9iZrzCMzjDKwjLIOpBiJeczYOh6qcvOzIXQB050MltD/3z9fhtsg/47S4QtO5UYyBpqrJKcjRBwhmIc2O36k03RzNudtsL0fkUuE7opcXEuaZE/Gc8j4IL56DBlSxCr72pAEJ716x4f/H39L88WRmi9b/xrLzv5QSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83gsPCeFvRHq/Iv/LxFKBJAl3DKn6KSlfcJbhzQwLpo=;
 b=Ugb/k3dYp9qKvSVcPlFTUK197mVobtyj5YTBgQfN68nE/nxMDfqOnk2cp0v2PHlHFjwzCcP+FfZDRfJuim1bXT/mEfprG8jS1Nhia/hD5O7HtsOixDVntkX2CTJ4byhrAYaK4rseIhXmXsomn2U1mESfuD5NCAua4gG4t+Xd4W4b8kBAeJe3Y/HPEXc953n34ap7Icuy//J34iFE6Hg/j+Bp1EldoEJ2t8CpcLEKPaO5hGRwpuGq9n+5qIhjqNib1jbHdi2ylfJunuZKhtFp6WrT829BLvNBnPrkUQ7SftM0XW+CXcyJPOYt0qoIk0/C6tOhCsgijlgg52ddJmMlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83gsPCeFvRHq/Iv/LxFKBJAl3DKn6KSlfcJbhzQwLpo=;
 b=XZFT7L43Kb+B6wX5kMS+xArmXiWfk31WkL4BRRkmyKjF0ONLkpd1ErjXTTctQaKIVsiRvGofRo+ut/yh4PepqThN+ToCiPtck/u5F+OFhM0QMNR2UMyYe2xMeKsYXSDP+hJ9DxOtoLGbOVV797fSynEW0O4ykiXmYgdZBvn9hYI=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:43:47 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:43:47 +0000
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
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [EXTERNAL] [PATCH v5 05/10] x86/hyperv/vtl: Set real_mode_header
 in hv_vtl_init_platform()
Thread-Topic: [EXTERNAL] [PATCH v5 05/10] x86/hyperv/vtl: Set real_mode_header
 in hv_vtl_init_platform()
Thread-Index: AQHb592yxIrq8MtOqU+tYI02cx5sL7SQe6iA
Date: Fri, 12 Sep 2025 20:43:47 +0000
Message-ID:
 <DS3PR21MB58781CFA8BEFF22D9BA407B1BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-5-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-5-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d29f05a0-df95-4cf4-a491-87a28f2af5ff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:42:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: 8ee1b2af-8b35-4c63-d6e9-08ddf23d128f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEpUVlVDOFdFN0V6RTFucDJ2d01CdEhVRWZDY29UTkhHYUxzemJFOFVpbWtr?=
 =?utf-8?B?dHZrbDk2Tm50N1RhRHB2TmQ1bnVvb2N6WnhOQy9iQkZ2Sk1zNGNkMnRxTDE4?=
 =?utf-8?B?NFhqSUh1SFJ1U0x2U1JvemZlMzhOcHlpeDM4THJRWmVhVEdsN2JWeSt0M0Vj?=
 =?utf-8?B?WGRtc1JDa0pYNXY3MWVZN05GL1hreUFvK3FvTHF2cjh4UHYwWmpZVU5VMktC?=
 =?utf-8?B?Ris4dGRGRGNKZDIvRXR1QnFmMHp6djNEM094YUQ1dGRvbUF4OXdKMVFXMStJ?=
 =?utf-8?B?M2hrdXFkZ1pSNVJ1RHFxaGtxRFBlTVVNUzYyS080TnhzZG11Q2llbGlKbktz?=
 =?utf-8?B?Yk02d0lkT0JtQkVrQXNGd2RQNmQ5NlNtYjZCNDA0Z3EwY1JCL0xIR0QvUmpa?=
 =?utf-8?B?TWI1MGE2VXJZblMzQXhyd0tyNXdVeEFQcUVWV1lYNFdRZHk5Z2hMbDlSKytU?=
 =?utf-8?B?NDFvSENqWkhldzdSYWRUd1JiQTZWWUFGQnpYb0dRczJkMHA3YXJCTU9XbUxk?=
 =?utf-8?B?aTlncUhvelVCdVRlUHVJQjRaR3JLY1pYUDN4TkhJRHQ3RndBVkR6L3FEYlAr?=
 =?utf-8?B?ejhuTEF0MmFqUXhDTWVFVGgvTGZydVRydlV5Zkxia09ZVUp6bXRnZCtETFZK?=
 =?utf-8?B?anZMVUZ1Z0VENlJ5UFpNNDFDeGYrTUIzM3JYdVdUSjFaNVZtYktaUkxMVlhl?=
 =?utf-8?B?NExYNU1KL01jckRwTDZvT0k0eVNrbEovSGxTNWhhSEtuL0RxY0pBRXRVVVNM?=
 =?utf-8?B?NElMSENpOE80bEJmN0VXTEdHbFFTcTRYOXpWSGppWG1Qa0N4dmdsQ1ZSSE5k?=
 =?utf-8?B?eVowSXR6Wi95ZU9IaUY1OUhDeHgxY0dlaCt1dFJoVHNQVGlUMmhBSDc3TU5l?=
 =?utf-8?B?bXRSSnV6dkNSaGdSeThYUGlrQ1FVVnVyODFNWDI1SmJ1b05xZUE2MU5NbnJZ?=
 =?utf-8?B?dVNBN1lEVVJEaFZ6VlBFTk1BSnJVSk1LcUVKWTVPTDRJMkN2cHVkTjJjaytI?=
 =?utf-8?B?eHZwemRsdE9YQkh1bXhnaHFqZDBiNk5JZkhCVFg5UVg5QXdiT2trQTdwYmlQ?=
 =?utf-8?B?TXFoS3Q4cVJtN3UzVDkxeVJDOHVnWWZvQXZYZjY0VU9WTzdDNktmNVRDWGVD?=
 =?utf-8?B?cjhZVjR4ZFYrWTBPeUc5TmRwZENsdW5DSFJ5Y3dDWnl0LzVzdFBGVmEyeHZp?=
 =?utf-8?B?Tmp4RTNNWERnRXpRdEpxN0ptZFFQM2ZGNDE4Q2JZRlZtVWtHUFlmWDFXZk5a?=
 =?utf-8?B?RUNaazRqNEdJMDNoZDJDSDZ3eWtiOU1DOCtYZHA2UkhRc2RHNU96QUxQbTRJ?=
 =?utf-8?B?azNNYW85VGNUWnNVRHJCdSt1UmE3N3JBUEJCN3M0Z1pJTVZrUlhhU1VCMEJa?=
 =?utf-8?B?V1Rtb05Ka3g5U1c4djdxTEJOSmJhcHZsWkM1d3NhR01PTlVVV2N3Yk1qWGFU?=
 =?utf-8?B?Q3YyR284ZnBOdW1oY282czVrN3VaT3ZCVzBrQ2FHMi9DSkFOMmtaWVJEd1Vv?=
 =?utf-8?B?eXR3TUNoaEZkbVBDUzYyY29YRUhYOWVROGhuN3c0K05KOEdIWjBubGdTdFdj?=
 =?utf-8?B?NGZFelFXaGp5ZkRVTXFtUnZkQ1ZnYkJkZDZqUXVrRVJ6REZtd2l5dGx6bFpW?=
 =?utf-8?B?QmlJdG9VUkwxeUl5bGc1ZEkxT2lMSFUwZXhCYTRwNklDalZoYkpsYnU4dUo2?=
 =?utf-8?B?cEdiQitqNUhSZFczdHRreTNka0p6UTJ1Z3RFamtWOUVXT1RJekk1c1RQdEVP?=
 =?utf-8?B?MFo0SU9zOU5zY0swN1paWVdpM2hHcVVBT3hhanhoc2xFWkdIdVlveWhPOVlF?=
 =?utf-8?B?eTRXSnZ1UlpaT01QU3NGUDZhenVoZjZaZnJIZDFWaFZLYUJmMHdPYnpsK2pL?=
 =?utf-8?B?ODMyNEpZdk9xOTNMWDdwTzlRSWs5cDFVWUYweXdvdm5PY25vUEU1bnRUbTFz?=
 =?utf-8?B?T2R6UUwyOWtYakJmZEVhSk9tR2svbHZBdm0zZkx0dXBpamJCUEt4ZlhYcW16?=
 =?utf-8?Q?vV5oWFLR82DFo+KSZA80UAVZB6yWe8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzdSaXdFVTl4Vlp0UGdqeUZNMER1TXk4cGlDOWZQRjlpV3Z2bmplNENpR0ps?=
 =?utf-8?B?U0w3V1lWWkdlTGovcWtJM0NMZlpsQ05WYU1WUW9kNFRTNWgzdGhUeDc2bFJm?=
 =?utf-8?B?UDcxbzJVa3ByK0sxdGtjVnp3ZVA3RG5CbkFHaEE2QVdXbFQ0SVlILys0bytJ?=
 =?utf-8?B?RGlLYkRLb1lZNU94RW5mZEdBUVFEYXQ2YW9hajU0dmorM0hvSUZBcGdlSHV6?=
 =?utf-8?B?c0V6VXlsc053WHhrQVBGejFjMUF5R1dIZmJTZTRCM1duZXUrVnMwdThLaEVi?=
 =?utf-8?B?OHFrVHUrZUtkelFSbHZ0REZZQXo1Qjl5QVZnK1FtU2g2bGlxd05PaEF4VG0x?=
 =?utf-8?B?WmVQNTdRdGFML3JnaW5heWJDb3VURnNLdkk3Q2pvcnhBV25vVVlHd2M5U0sx?=
 =?utf-8?B?R1pSMnlsYlA4cE9FL3JjSjFyTkNNTFR0WkljR042UHI3WmZXKzBZL2RCVmpC?=
 =?utf-8?B?cW9waGYwR2UyYjNJZ3ZPLyt3Nlgybzh1NkxIN2EzREhnWUJoMkVTWnpjaFhW?=
 =?utf-8?B?STRpdGVML3JqblNZaW5qWW81WkZ4b0Z0dXFEQUYzWERrdllvN1djN0I2Yk9n?=
 =?utf-8?B?Z09yNWkrTEs3OTBjd1hiQXVESEg5Q0FYUnp1eEhGOEJNL1NPR0Z5SVA3cTRz?=
 =?utf-8?B?UElhNWd0NkZDSDZIUkMzRnUvbDJrdEM5ZHJDR3dPbm5PdGUrNFB0WGkreXlm?=
 =?utf-8?B?QVl3dEFlRzB0aUN4Z25paUs0RXplcEcxaHJBRlVHQ3NPMUNYeEZoMnlzS0N3?=
 =?utf-8?B?YTdSeGZSL1FqVFVEQ09RWDF3bzVyak4zL2hrTEY0LzlEbVZWb1JDRXcwQzR3?=
 =?utf-8?B?cXRsQ3VPOFk1WkxrR0FORlFTSGY0UXRJQzA1UERXTTk5dG1UK05xYzRGaHRO?=
 =?utf-8?B?eTJ4QXRrL2tueGpTRnFkZjh0WkdyVXlFNXRJMmtPd2RYN0YwTnNIQTBlYWhI?=
 =?utf-8?B?MkIzL1ZqN2N2R2VSaXlJdGZrZythQlJ4QVdMQjlySzVSODEvam1kbFI0aVBL?=
 =?utf-8?B?c2NsQ1owbERSUWRVNlU0c21GeS9ONmkvN055eGMwdExBUjVHWTFqQjZESnlV?=
 =?utf-8?B?WUlOUStwZUdQT0ZiOThEa3J2czg3bmV1aDZOVlkwRDk5eXlFa2s5ekVuSVB6?=
 =?utf-8?B?Wll1bHNQc3MxWXY5YXowZ3J3WklLRnpHNDRUM2xOcDAzWEJuVi81M205bE5Y?=
 =?utf-8?B?Y2dyMVIzSFVienBvOXNoQzN1UmhMMjRQZVZEMlVBamQrdFd4cjNJRC84ekxQ?=
 =?utf-8?B?ZkFGc20rbmdRTXMrRHQ4SHF3Z2VCNWpBMkNPNGZNUlBTb20xZjMyNHIzMzhN?=
 =?utf-8?B?WUZPWi91TEdlMk5YWDlKd1dmaHpGb3lEMmlFY0hZbDQzTGwrOWxneXhnc1Fp?=
 =?utf-8?B?MWFTVGFKM3FwUURDZ0lIOHUweGExb1ZDWDExVlgxQ2FvUnhUMXhNbk96WDVq?=
 =?utf-8?B?VllIQjd3TzFZY0NQd1RNQytqWHB4Mm5ld21wcVFUVkQ3N3BjUEoyMms0cnV3?=
 =?utf-8?B?SElTTnpXakZKbS9IeFZJcFFydVpYaVZ0YmtQNjYyZXFSTmJ6Z2NJSHg2RnJ4?=
 =?utf-8?B?RzJYWnNlbmdkaWRrQUNLeG9hVUptVU1pRVM5d01CQWhIMXl6ZmRyczI4enFE?=
 =?utf-8?B?RVkzcE9VN3F0QzlTdmREVVJGNDc1T3hVb2xlMnZCcnVGcHFqbWhlMTlDaXo1?=
 =?utf-8?B?RjNiblJOYUhoWU1zNDV0b2hzaEdOd0ZOVG9FYk5HeVYwOFYxT2FZMW5tYVh1?=
 =?utf-8?B?dUdseU15b0U3UXNSdCtBektsU240bWx3anNCR2V5ZzNXOWUwd3VOTDFXb1U0?=
 =?utf-8?B?QU9pVE94bE1NV21qUlQ5RElZZENlVWMzWUpXeFBKMDEvU1VNdGlhZzZIVkVM?=
 =?utf-8?B?MWRLaGx1MkhOQmZ5RGtwSEJpYk1kRjA1WCsrTjFXVms2MmM1S3l4QzNlaVVq?=
 =?utf-8?B?VU5xMlVjc3pXaG14VnZ0TStFaHNJaHlRL2NFeUlUa21zVzl3dEc0TDVqMlND?=
 =?utf-8?B?YnJiZWZMdkpVRytLdGlVeElrM2JjQ0E4ZVVFL1FEN1o5NU9kNTlIM3N3cWZB?=
 =?utf-8?B?aXI2eUY5V3BIL01VK0NhYkhPcGhiekcvcFN6aFM3R2dOMThWT09JWWRVa2pr?=
 =?utf-8?B?STNtdEVIZmtvK2RzMEVNSlNldURzVjY5SnhKUGswSjQxNUZzejZQcVhyaUk4?=
 =?utf-8?Q?sgkjlahfBpra5X7HUIG+mokSFlhwo/twY0WK/kH1pEjD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee1b2af-8b35-4c63-d6e9-08ddf23d128f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:43:47.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKqVoozjZ4tpq2WegPFjgSXDU5qEbagYyEnJupTqK/vMqNo89nJFtWTkHp68mr056trzzrqyo5TKViNW5Krecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+Wy4uLl0NCj4gRnJv
bTogWXVuaG9uZyBKaWFuZyA8eXVuaG9uZy5qaWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBI
eXBlci1WIFZUTCBjbGVhcnMgeDg2X3BsYXRmb3JtLnJlYWxtb2RlX3tpbml0KCksIHJlc2VydmUo
KX0gaW4NCj4gaHZfdnRsX3BsYXRmb3JtX2luaXQoKSB3aGVyZWFzIGl0IHNldHMgcmVhbF9tb2Rl
X2hlYWRlciBsYXRlciBpbg0KDQpzL2h2X3Z0bF9wbGF0Zm9ybV9pbml0L2h2X3Z0bF9pbml0X3Bs
YXRmb3JtLw0KDQpvdGhlcndpc2UgTEdUTQ0KDQpSZXZpZXdlZC1ieTogRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT4NCg==

