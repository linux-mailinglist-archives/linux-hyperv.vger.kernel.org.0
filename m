Return-Path: <linux-hyperv+bounces-6839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915DB554DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505FCAC291E
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4931D364;
	Fri, 12 Sep 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hgzc6nW9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022083.outbound.protection.outlook.com [40.93.195.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142C275B05;
	Fri, 12 Sep 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695442; cv=fail; b=uCGSKlPcrlr7r2AC0T2+2/TwN0OOkDczQvecIMkEvjTrqecKsGZwCXN8NePJyRxA12F419kAt4sluDRPdyi1G+UbtEVfBdbMBZK1AY2auGP1xuEEH+Rk6GERtHofrRyxio35WWnZdyHyp67B635kAc27UJc5yz91CMZ/PdQet/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695442; c=relaxed/simple;
	bh=K9KtbiO2tVjjTS2tKB47BlTk8edP9WwksViPHUbhl9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JY0GMkpe8UWU6kfkgymcLSjSfWzmp0MLBTpl2MMakuirI4TftrC+T2ffMJ3iUm5BZzXkqtzRYx2Rf//XKkL4tzCl9eTJLR8D2MpndWJwYrFhPAz8vd9k7WRvmDIql79NyJvi9UcYwCKyF9OBkuHkiCnRQ9OwoPMZ+qD6IyeZBtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hgzc6nW9; arc=fail smtp.client-ip=40.93.195.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5rMCLmgNmwD98yWwOL5EdWuZRj9It4fxRL1wcLxl7TGaMIc+3EhsMzcSZkOX7jSwVdo3mWLKkqMn5sxs3Nx6+d5K5jC8HI2pKMZAM0OpPIDQXldifeR7e4M/O02clGpi5m5/bw7a715mfBt+JleO9SYQfrxvSB7C3mcFE3ddsna62bvN1DHMwIyBVovPDMYJGLiTB7n6ohj6Qnx+jrrntM1E9H/8W343belvTtReZPYwHK7HrdMHXFKZYd09gcOg++bbObAQiqXYplQxeOK5xzG6JoxgRaSY8w5+RB513+4T4WgIw81QGoYCMVXfQFdAYaUfudjQRI7J1+Q075P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9KtbiO2tVjjTS2tKB47BlTk8edP9WwksViPHUbhl9w=;
 b=kn0cPbL8YRjxaYqvV9nDjjNAYHerJsJPogjV3t3doR/Fl4oIyVP6sqBC2hLd2jJlBtqsP7mtks6H2uvZoWvcHyHEMtKKDmvLTDQRY4fe/P+I/7Z9wq6eOIw1SaPFf9K3l63Cbt+TscNb3YrgIwYhdOJLKKrjKAeitWf1N3kJf//S9URmw8/oREOZvbsWkF5hsEMaDmWtCZcUNQaJoK0/FQg0GW3q9GAnuxyyqlXi31C1v6jwKS4XZG26MtZSEcD0gI2YVLVLGZCQZMZtVQf0s1/AG/7CKey/f4tpu4VaO2fu9KOd95j1EqHiZt5Jah7GmRs4FvILdQ+zI9fu6BlymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9KtbiO2tVjjTS2tKB47BlTk8edP9WwksViPHUbhl9w=;
 b=hgzc6nW9dIwVCV97ZnuVbmHVR+iJWgpCN/NKnBldRTB8NYf7hsCFz0RNLG0Y7SiQqGphJlWN19I0KJRT1cOuxzRe69se8dERxLHL7IgmzB5yteiR6LMk4pyjbYNe/IS1Itsl/boMu3nccJiz7V9c+6AP4l+ZM7VIMN+mxfAo8lE=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS0PR21MB4132.namprd21.prod.outlook.com (2603:10b6:8:1d1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.7; Fri, 12 Sep 2025 16:43:57 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 16:43:57 +0000
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
	<ricardo.neri@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 01/10] x86/acpi: Add a helper functions to
 setup and access the wakeup mailbox
Thread-Topic: [EXTERNAL] [PATCH v5 01/10] x86/acpi: Add a helper functions to
 setup and access the wakeup mailbox
Thread-Index: AQHb592vK46pzf+ORku9zKpTDZ6ej7SQOJEg
Date: Fri, 12 Sep 2025 16:43:57 +0000
Message-ID:
 <DS3PR21MB5878CE2590AB1899D9489B7ABF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4be3f139-37aa-440b-82ae-1929ebf47653;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T16:41:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS0PR21MB4132:EE_
x-ms-office365-filtering-correlation-id: d6100a80-89fd-46fd-5c7e-08ddf21b9179
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlpqTERvZUlsS2VwVjFTSW9SeEMrT0NBUXBybTVzeUtycktBeUUzemZjL01m?=
 =?utf-8?B?ZzdDSHJuNmJCVEZhcGtON2NRWVpwV3g4NzZiOEYzR1BUUEwyRU0zUlhXMXp0?=
 =?utf-8?B?VmNVNzFCNnBaN0lpR3RWRjdqL0RFcWlyamoxckVkRGdhR2FXTlhyMHJQanBW?=
 =?utf-8?B?NFRaSENndzBEVUVDWHVpcHpIbmV5Y01rSnhWTjhNREdMNVpiZmgxYmp4NUpv?=
 =?utf-8?B?aWxZVXJmY3lVQzJCUUIvM2MwWGFFTkZ5ajI5Z2tYbGNsOUM4U0wwbCtVSEE5?=
 =?utf-8?B?VzRVUlBYR2xpM3VBb0JTRUN6cWxIQnRRZWJSVXJSNVN0a21YaklmRG9hdEpV?=
 =?utf-8?B?RVdjNjZxeUJlcVZ5WVhhZ0dEKzNFdjlsSDNVdS8rdVVhdG1KSGUvNzBwTFgr?=
 =?utf-8?B?Tnh1c0MvQ0FQcnd3OTJyU0NnN1p5Vy9DcWpEbnQxVG5oNjJRTWV5enRBSGp4?=
 =?utf-8?B?cHBMWlFrSXZGemtCU0lGMHRDbW5FQ0xiNjhvaFl2aTFiM0orL1kvMmVZeVBa?=
 =?utf-8?B?N2xiakNMSHlvWXJISHdUTy9YL2lYV1BBb1FMREFEcVN3TWRabWhXYlZHWEJQ?=
 =?utf-8?B?WkdubWZzM1FPaFlzK3BJVnhnSnJ4T3l1VEliZitHN3J2QWpTc3dDRTRVOE96?=
 =?utf-8?B?dU5vTWdaSTZremFoYlhIMzUvcmRYZEdXS0I5VlQ0Wms3NWtpR0QybnRWNVNK?=
 =?utf-8?B?N2JWRDloWTZSYjcxdEIzMmZEbGdNQmdqYlBucmRKU05hZCtSTDlwNlNVZkQ3?=
 =?utf-8?B?cExpRVFIem5PWVdqR2dFTzBhSm5ZZmZuRVN2WkFkdVhIWkN2R1JleEtXN1d1?=
 =?utf-8?B?UzgzUjBwSnhCK1lFVnQ0TmVTdGFDckhGTklNb29IbGcra1A2T0YwbWw4OWlp?=
 =?utf-8?B?WUJYSGhtT3laMnFncnliRk56RmsvTkdoMlk2bnYrSFdKTWUyaVU0TjlTZ3VZ?=
 =?utf-8?B?ZUx6b3dvZjIxM0Y0cFRGRjBINkE2czNYVm1NZ2dEV1lVM0lPbEp2MzEzRWNa?=
 =?utf-8?B?M1NpcDBtYkhUQ1Z5Y3UxYXF3TERPS3FBNkJuSU5UQm9CeHUvdzFONzArMjE2?=
 =?utf-8?B?UGtsc3dobEhaK1NqNzFTeXU5WnhnUTBmbTBrT3VTaDZZcmtBV3lpT3l1SzRF?=
 =?utf-8?B?WXVBV0tZenBFM3lVbWJjOWxUdGUrUjZIS3FFOUJNTVlYMDlta3FDcEJGUHcv?=
 =?utf-8?B?OUZJeEw3N2oySUE0Z1NZWWFyL1FrTGpNUkZ5OEdoWnpTMVhYWHdWUzc2NDE0?=
 =?utf-8?B?QmtlaWFGbGh1R3ZjNDV2UWlBUk5DN2Rram1waUdWaGFXOHRjb04zSGhOTzA0?=
 =?utf-8?B?bS84MSt6cmx5RGpoOHF6YTR5NDlHLzRDcXBKaVkzOG9SMmlwREczRHJSZ2VX?=
 =?utf-8?B?cjY1anIvTHNrTlVteVI5cE42UC9WNStod2liSXBZMGlPWlNKYTQybnFFdG0r?=
 =?utf-8?B?ZTVERDJJejducnZ1MFdLMmdwTEQrYXR2bktiWjcyTjBMMW9waEJXTTUyRkpK?=
 =?utf-8?B?dy94c1ZSODhrSlNrNHBOMDNBcnJEcEc3dWtVeis3eXJuL0VDZHVtdU5KUDIw?=
 =?utf-8?B?aDhsZ2xlY1RUNWltZnlWUlBRNUI1UHlMUWVWQjd3OFlKYUcyMVYzUEtFeDFo?=
 =?utf-8?B?L1VING1lWTUyQ25laHJtYnE0c045Nm40MmtQMno5TmRWZDduVzdYclcwcmNl?=
 =?utf-8?B?ZU9wNk1HWHIraU4vL2xwMXFGYnYxSkFRSFpnWHVHcDRieWsxdUp1RWpWSDcv?=
 =?utf-8?B?UHEvMWxhZWVvYVRkMDJrbkErT0MrSndObFJQN1RiTlZLbW5xVnhoTkczUXF3?=
 =?utf-8?B?elc2dzZvdmI3aFhKK0YyQ1hJQ2hoYVF6NWtYMGtpWCtkSExrTENYV1VmMmcv?=
 =?utf-8?B?L0puMGhhdW9kMEVBMjN6YTFzYVppWDREZjZUYWlpZDB4ajR0RmM1MFg3bjJr?=
 =?utf-8?B?NWxKeGVSUnE3M2NJQTQvWkJhazdBdTVZUk14MzgwWUF6enNHZ3VoanpPSDRp?=
 =?utf-8?Q?1PRGGPD6kxjl0LI5HxTRW4SAE5G0HY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmNoL2dIaC9uWmh6Q0lMUExQRXZJeFMyUk9udWN6bmJoZ2M5SjRPbVpYdzEv?=
 =?utf-8?B?eTNPaWtFZ2JFZ0Y2WmR3dVg3b0Y4ZnMwL2ExcEpqOWJBd3dVNldsMWJHZmFz?=
 =?utf-8?B?cUpQTTJKUlNKRWI2Sm4ycHNGQ2svbkJwNUl0dkN0L3JMWDZjRHE0bmNBcmh6?=
 =?utf-8?B?R0xnNDZqTm80Tzh6cUdrUjVORlR3aCtDVnNPVnJqM2d0bytaWTAzU2ZUUW9r?=
 =?utf-8?B?MHVGcStSUzliMTVKZXdDVUlnTEVuQUl4MWZuZTIvREpPMVN0M3l6RG9kTXZP?=
 =?utf-8?B?TkZ1Z3hNN1Iwd2JQczhLUGhzNXhTZDJESDJ4dFJmT2MyZ082M0tVMHJCNy9P?=
 =?utf-8?B?SHRnbVRhRFdHK2ZSYTY2WStlZlNwRHY5NmhyQ1BBSGM5dFpVR1Vld1ZvTWpM?=
 =?utf-8?B?eTVRZkNaU0dCNVdGWE1CMmJwMEJnTkpiS1RRM0JGaVBXbU9zeDViR3ZnYjhB?=
 =?utf-8?B?L3FzcndPWS9JNktRTWsrb3AxUGtYekhlTjgxVmh6eUgveUhiMWIwM2l3UXBn?=
 =?utf-8?B?Q3llZjBrTlE4ODA0QjFDUUxCTlMwbmExVWZ3T1hsdlB4STB5SWtkdWttVDJR?=
 =?utf-8?B?NWUyUHRrU2Qya2NZb0ppT09XbFc2MG1pTklnaXBmNmgyM25kL1ZySk5jSjMx?=
 =?utf-8?B?VmtlM2psMGtITWlYa3JPN0ZTS05qNnk4VVBJMzZrNlF6WE05eE1NMFNFTk5N?=
 =?utf-8?B?bTBKYXRnWEtyZEgrRnM5N1gzRkxaOCtmbi9xMjVWdVl2ekxtLy9EeTgwUzI1?=
 =?utf-8?B?NmthNE5xMUdxSTJTaGtoWmwzN2p3YTN2aEt0WW4wTzRFN3M3K2FwcDhWVHBV?=
 =?utf-8?B?ay9DeGZQS2MxazFSTVkrZkFkcXp0UDlSN2FTTkIwMmhXQjFZMXRxb2RFUk1m?=
 =?utf-8?B?dXl2QjQ4eDB5QndPaHVpdHZuaUw0RnEwcWJRWE1BY0ZXZ2w2OUJLMjRMeWFq?=
 =?utf-8?B?QUt1alBzUG1RSWdHOTlHSVROYStibGdSN2djT1BodzJ2ZkhmY2tIRndvZ1VC?=
 =?utf-8?B?c3hrRUNjWXdVMjhlSUtubGUvdDRUSVFoVlNTVjJBaDF5d1hzZVBJdERwRWlL?=
 =?utf-8?B?cE1kZndETy9HaklLMUpZaVhHM0RjbjZXVG15N1c2V0pqNEpKQXQ1S0VPKzdz?=
 =?utf-8?B?QkZ4azFzR2dMVUZudU1qNFpXRkc4TFRPN3Q2QUtRVmVrejhqMXpic0hzbDUw?=
 =?utf-8?B?dExZUDZTczF5aCtpUmkyWHQxZXNVUHI1VmtuZXVpTGxBZExHRkVOc041amVL?=
 =?utf-8?B?WDRHQkRZKzEvR095K3NUbktVcFRuc09kN3VWOUowaGdKeWFHY0s1ZWlrSlNO?=
 =?utf-8?B?V1BBTDdDMER5MlFjTHREMlZKM3lyU2RTN3M3RXVHak1lMkRxdXhPUTU3UzYv?=
 =?utf-8?B?QUVhM3NFT3gwN0d5SytnQUR3TTJuTHNuTkRYdjVtODYrZkZwVURhbi9qcXEy?=
 =?utf-8?B?K0RMT09CSCszcVZUdTVqcGFGRUtOd1VkRk0xa3VzT1NYalNITEkyajlucUxv?=
 =?utf-8?B?UkQyd0hYcjBhQU5jb084V1B1cFJ5R0JMZ3pVZWpTUlhrSjFJZE5BRWc5cmIv?=
 =?utf-8?B?bXhlejlDMmU2WEVaVDltQkRMZEhCY1ltSkwraEY5R3k0c2JOYi9jR1piVThB?=
 =?utf-8?B?TDcvS2JHUlF6T1FWUmdSNXJITTI1M1FSVGl0bEJzbEVTL0ZFMVB3a2FJdTBQ?=
 =?utf-8?B?WDhGdExyOGVQV0tIVnVPdFdCVG5GaVRMRHR2MnlHMXFhQkpURkladEV6cjIw?=
 =?utf-8?B?c0lPZ0VWSndwSGhSRERBQ3BFWUVmQWxhci8yOEQ3bzVSSW1JTkpSOWZiaW0r?=
 =?utf-8?B?NTNsMU1hN0cvd0JEam9wZWR3REV5QkNBMnc4cnFZV1NlR0JWdDNrV3NJZHdo?=
 =?utf-8?B?YTlEazBHS1l5REJtQTFzay8yV3BaOWUwSVlSUVNDb081THVYU3pYb2tHUWVH?=
 =?utf-8?B?Z2dKaUprT1ZNOEVDNFY5SkFnZ3VRTjMrMHZERVAveEtob09uTWcwU0c3b3lB?=
 =?utf-8?B?Q25ncWZCKzBmMjdvSmRveEd6b2FQMmVoNnorWERJeVBPbUdyYnZEWWs5UXRC?=
 =?utf-8?B?anFRbTVFRTFvZ3NkRUZvTlJIV2o3dDRKVHVSNTRkUGN6M3NzUzhaTVMxdWNw?=
 =?utf-8?B?cStFbHVkcXo4T3hPM1ZIQklmMEttcjlRWlJybHBSL1NwV0R0YTVaTUwxQUJx?=
 =?utf-8?Q?DdPVxhLDfyCGxcXi2rDHyrO6hu4NItgvI3jk4eoosFBs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6100a80-89fd-46fd-5c7e-08ddf21b9179
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 16:43:57.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S16WiE/1+rEvpfzSCqbOyCbDGWU8iwyF27A1zPjgKnGkE3LG6q3E6w4HUACxS5dbxYyfvwAyk1YwyriD7KPOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB4132

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IElu
IHByZXBhcmF0aW9uIHRvIG1vdmUgdGhlIGZ1bmN0aW9uYWxpdHkgdG8gd2FrZSBzZWNvbmRhcnkg
Q1BVcyB1cCBvdXQgb2YNCj4gdGhlIEFDUEkgY29kZSwgYWRkIHR3byBoZWxwZXIgZnVuY3Rpb25z
Lg0KPiANCj4gVGhlIGZ1bmN0aW9uIGFjcGlfc2V0dXBfbXBfd2FrZXVwX21haWxib3goKSBzdG9y
ZXMgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YNCj4gdGhlIG1haWxib3ggYW5kIHVwZGF0ZXMgdGhl
IHdha2V1cF9zZWNvbmRhcnlfY3B1XzY0KCkgQVBJQyBjYWxsYmFjay4NCj4gDQo+IFRoZXJlIGlz
IGEgc2xpZ2h0IGNoYW5nZSBpbiBiZWhhdmlvcjogbm93IHRoZSBBUElDIGNhbGxiYWNrIGlzIHVw
ZGF0ZWQNCj4gYmVmb3JlIGNvbmZpZ3VyaW5nIENQVSBob3RwbHVnIG9mZmxpbmUgYmVoYXZpb3Iu
IFRoaXMgaXMgZmluZSBhcyB0aGUgQVBJQw0KPiBjYWxsYmFjayBjb250aW51ZXMgdG8gYmUgdXBk
YXRlZCB1bmNvbmRpdGlvbmFsbHksIHJlZ2FyZGxlc3Mgb2YgdGhlDQo+IHJlc3RyaWN0aW9uIG9u
IENQVSBvZmZsaW5pbmcuDQo+IA0KPiBUaGUgZnVuY3Rpb24gYWNwaV9tYWR0X211bHRpcHJvY193
YWtldXBfbWFpbGJveCgpIHJldHVybnMgYSBwb2ludGVyIHRvIHRoZQ0KPiBtYWlsYm94LiBVc2Ug
dGhpcyBoZWxwZXIgZnVuY3Rpb24gb25seSBpbiB0aGUgcG9ydGlvbnMgb2YgdGhlIGNvZGUgZm9y
DQo+IHdoaWNoIHRoZSB2YXJpYWJsZSBhY3BpX21wX3dha2VfbWFpbGJveCB3aWxsIGJlIG91dCBv
ZiBzY29wZSBvbmNlIGl0IGlzDQo+IHJlbG9jYXRlZCBvdXQgb2YgdGhlIEFDUEkgZGlyZWN0b3J5
Lg0KPiANCj4gVGhlIHdha2V1cCBtYWlsYm94IGlzIG9ubHkgc3VwcG9ydGVkIGZvciBDT05GSUdf
WDg2XzY0IGFuZCBuZWVkZWQgb25seQ0KPiB3aXRoDQo+IENPTkZJR19TTVA9eS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFJpY2FyZG8gTmVyaSA8cmljYXJkby5uZXJpLWNhbGRlcm9uQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gLS0tDQoNCkxHVE0NCg0KUmV2aWV3ZWQtYnk6IERleHVhbiBDdWkgPGRlY3Vp
QG1pY3Jvc29mdC5jb20+DQo=

