Return-Path: <linux-hyperv+bounces-10816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIdAHPHsA2o5AwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10816-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:16:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D040152CB31
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7C7300F51F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 03:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C83264D9;
	Wed, 13 May 2026 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VDb02Ms5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012010.outbound.protection.outlook.com [52.103.23.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414A5477E;
	Wed, 13 May 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642158; cv=fail; b=LGiMKUAFOrEu79Z3LTKsQoEidYdf39EEfltliSAE3OsH/T+NjzGiNP+ATR2f6D8FbuTrg7aSXfDEERG55ifqMm5UI+9GiG0XXpZzFNaVxuDYV6rwNb6YCwGD8KbYkzqtpIQLv+1I7+RvJgGFKlvNXTcpHH82Af8x3neQh4ctPFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642158; c=relaxed/simple;
	bh=MtS636NZHi+sJfealQ9TNg2x3kG2VGLEWpH2cAYZkvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evBScINEqh4d3n7+CYTDq/AvUXmrsJ04AnLEJcuyfks0rEnPNQTQzCvmsNzwhCspi8ng3Z8pofH84MC8kYm20cMzIKV2nG/Eiq0z9Ce1EFTxauEuP7FLj0gG8X4Dse2ek41V3s1fNZV+m5RFnyUGFnLH5eifRa9VMCRV4fNYmm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VDb02Ms5; arc=fail smtp.client-ip=52.103.23.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbRA6SS87gGX6DKZuNv6x4Zj9EDFyYgI+Vy4jdB8I8zwaS0jOUMS63NGto1mIkAQ/Qm7TNvx7OVL/2Sl6c5hZOV/B+9hLdmOtmWHr8aHj7boiFYG74ohz5eqUPQZChgdUikVifCGQCGlRLvyhNKymY7zBNwKssBnQIfNjLCphojoms1QSyGq19oVDTIJhi9SYt+6QiXDtY3agC1+v717QljbQn3nuYP1AaLSzja9ug7d7T3iQBbzYhmCx7GpFsXJGZG0eDK3NMNg+8Yhcxbdsdbf3rqqcaaOBReBOmD0G1R06bPCIY5TmDIZwL8peUlP5XMzluNpJ9ZKsCvhjE0OcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtS636NZHi+sJfealQ9TNg2x3kG2VGLEWpH2cAYZkvU=;
 b=R7ycb0lMQ/OUVuLJluDgJtU6PlvLty1l6p1/pvwTJROY/7sRNtdtTTOlq8KHEvghAMw2S1CKVstlaDGaYOnua/d3BkXfZ9uj6RfS+fRN4LgtdGAPj71bVT5URt5HTs3wGbBFXQuSPRJGovkJ1V8P5Q31pJRo9wXtU++tbSGccTGdNNaZ9W6OT4oqCjgl5yoM2vwQ1jAIJRgOvX0nOgvQhWS2n7Ti1NycBsTFA3e8O3c+bPsYmoMMK3SQ0E6AUSCNwg55MDvRSzxuMbcZnU+2fYBCVpZ24YcsVwK4XIdTQcJRZLZgMD9YE1151Kd3q0MUaM0TJGSD5FcKrs0Bv/ajEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtS636NZHi+sJfealQ9TNg2x3kG2VGLEWpH2cAYZkvU=;
 b=VDb02Ms56O6aYDNzbfZhhBp35TvCy+SA9d/rbt06FFgyKLaoxrrcaU7mslPpQTHvhMGFRZvbuNia2cswrx6jysMPeljVK3zaxEQUq92Bay0j9166/y/uV7aJ4rJSgI25/u7w6HhuUnRSoILcS1WjJYnZR6vpnRIoGeOtZWsIYuY5OJujPkEO0lJn4jEGQoLv0e4iNgUKKgLkzHYpV07dCT01sp2Nod8uV8jWUvHnBB1SpC0MwEkkQtgzOTjJSJw9WgX4nvEmoBoND6+ThlKdpjHDla8GHB1JkIpy/gsP38kzbEpWc1iky19DinleJ2yGd4R9ekOX1lNbQN8481AHpQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9181.namprd02.prod.outlook.com (2603:10b6:208:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 03:15:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:15:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Mukesh R
	<mrathor@linux.microsoft.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, "muislam@microsoft.com" <muislam@microsoft.com>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
	"magnuskulke@linux.microsoft.com" <magnuskulke@linux.microsoft.com>,
	"anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Thread-Topic: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Thread-Index: AQHc4bOBVgXmy5UnlESUrT55wvQDFbYLD62AgAA6e3A=
Date: Wed, 13 May 2026 03:15:52 +0000
Message-ID:
 <SN6PR02MB4157371A1A3931F582F9A2E9D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
	<20260512020259.1678627-2-mrathor@linux.microsoft.com>
 <20260512164623.0000273f@linux.microsoft.com>
In-Reply-To: <20260512164623.0000273f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9181:EE_
x-ms-office365-filtering-correlation-id: 4378399a-6ae2-4302-3070-08deb09df0a4
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|37011999003|19110799012|8060799015|8062599012|15080799012|55001999006|51005399006|19101099003|31061999003|10035399007|3412199025|440099028|4302099013|102099032|12091999003|1602099012|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjNQTFlDMExrMEE4MTZJdGtlSkpubTVjM2ZtcWJ5TUpFUTZ6a01JcmtMZVdn?=
 =?utf-8?B?RlRLb2VxR0U2ZjYvM3h2cWdSVXoyMHZTb0x3bGlhQzdDaXR3dVRFVnRCWFo1?=
 =?utf-8?B?NUhEdUpxZVA5WjY0Z0NmcHdoL1hsbjRxMnRXNXNQVTBESTdZSmFQc2lGaHA2?=
 =?utf-8?B?N1lwNTFxMWpDZmxEYmxBOFdVM1p5a2Q5K3crcXJjN3NkcnZHb1RMbFRHSzRC?=
 =?utf-8?B?aDBIZGRxL0ZpODNreGk5d3hUdWZvUU9tQWx4RmFhM0ozcDFUQ1l6V29IbU9W?=
 =?utf-8?B?WVNiOXgzbHNuZXNZNjJCTlNJdThGREZIVUlyZ0swZlVBMHJ4TDB4V1dOM2JT?=
 =?utf-8?B?WHRtMU4wOVYxb1pJejljODJlYThqWm1CdVEwc24vd3ZwVW4wR1I5NEZjdWVi?=
 =?utf-8?B?NllHb280SDd2NVd3YlFWZEhYUVZYMG5WVmJzUXFERzh6cGxnYWtEM0VqajN2?=
 =?utf-8?B?SkVNRk41cHk2cnlnbVg3UDlIWXNNVkU0R3owZzk0QWRBT1owYTVyRmtJb0ww?=
 =?utf-8?B?OHRYM2VvMUFpdm9Gc3hGRktBcFdZOE12aTZsWHFtckFBV05JVWNnSEZhZjU1?=
 =?utf-8?B?K0grRkp4TndJVE9IcUFMUllBYVBOREs4OTZVNEh1Ry9qdnVmWURCZXlDZ2dI?=
 =?utf-8?B?dnFxanhLdk1OUjBOcGY3M0RacWVkdFhaSTZ6ZXM0bEc1Sm9Jc2VEankxQm1V?=
 =?utf-8?B?RzFYbVBrRFZIY0FuVEd1ckZHTllDV3AzT1czV0txWEZIdHd3YnVLNk5vYlR3?=
 =?utf-8?B?RFFkNXFueDNMQjZ0dUh4MXdiemlyNVhLbmxkVDlUeFR2b0FBVEF3VnlxNGpj?=
 =?utf-8?B?cW82Ui9VRUZKc09VL20xTkh0dFFvQUIyZ3MyNURCb2hCTk9haXdPWFdBenpD?=
 =?utf-8?B?QlZLVXNyRHRRcnk5dVdFVkViVDdxaW02bEFGSDRBNE1EL2dvc1hpeHZZT25M?=
 =?utf-8?B?TXE5WVE2WFpjMGpBS3VrZlVCVjBES08rWnFRYWhlQkl0cWNUcWFrcWJyUDdU?=
 =?utf-8?B?VXZ1aHBGTFE3dTY5ek95UnRydEpSRmRMclprb0ovK3dIMVdPcTFnRTYvaXZD?=
 =?utf-8?B?VmUwQXdGdCtZWWJLenJEaWhRLy9GOU45djhqMjhPeWZjYy92SExrMVdPM1hR?=
 =?utf-8?B?enlpc1BBQW5yRzBXbCsxZmJLV1pOb2FXalluMUlaZHVDMWppSVppQ3plYjY0?=
 =?utf-8?B?V3NjUXdEeEVNTTY0Tm9DdHpRc3JneERDOWpic3JtNVBxMnM0NEw3UGROaTZW?=
 =?utf-8?B?OXM5cjhoeUlpU2U2YnMrKzVuUEFOdVlrMUFuQXRnVkJzYWt2TnFKdW5yakFZ?=
 =?utf-8?B?OVIzRWNIYVdPbmMxZVV0Y2gwUkk0VWQvUnhhN1FENWdBVHBsbjJQRFBUT01R?=
 =?utf-8?B?c1RXWElNSDJIckVNa2VXR1pEeG9ud2lYTEtNK29UTG5TeUFqaHNXSFNKUXFa?=
 =?utf-8?B?ZkNsNnF6VkJ2RGY4N05ObzR5U2xLYlRaU2xDRHdnenUxalljTnpWVHlteHNR?=
 =?utf-8?B?M083dUtsTHlLbm1EN3V2NGdleEpheFVuU2x4OTFUZW5BNERCZmpPQTRtQ2I3?=
 =?utf-8?Q?3zdYtWpROTkZWhW9/1ca6LYwELGy0i8qGAjj10ivS8cSnL?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmdXRThBTXZOcXdZU2hURUV4dnZXb0kvS1k1dFlUNElqaWNMYlVtM2RVdzl4?=
 =?utf-8?B?Q0NmWE5wRjQvV1NCVUREa3dLMVFIeWtrRXEwcWdVYlZacGZsc3hpSnArWDFV?=
 =?utf-8?B?Y2NSamJQWm1CZGwyWm5hV1pYdVlBTUpTK0w2ODFnSGY1a0grVG5Ja2wwUU4v?=
 =?utf-8?B?cXpicndSWVNVMFF6UnFEWHBnbHBkQURlZmlVKzh3cTRuRE41RUMrLy9FcVpu?=
 =?utf-8?B?eWVmY0pGeHVqTy9xbVhvdnFxbkhnd2h3VTMwNXJTeWlsQy9PV0lBbFl0a3M1?=
 =?utf-8?B?WEhsMFhZSnFWK1VqS2puU3lMaGZrNzFLSTd3SG5GNmVkNFFKUVp1NWowMjdL?=
 =?utf-8?B?QndMbHNhTUo4WjFIa2VyMzIrcG5rZnlnVmxXaFhaN0tvb2xuZmZXcGdTWWFD?=
 =?utf-8?B?SFkzdzJ1SmZIYVpzN0xQN3E1eXk3MUJqN1hWSUhQdHZaWVlRVDJudDJueFZn?=
 =?utf-8?B?bEl2Y2ZVWGExa2Q2ZzgvT0NyeUdkbUw5NnFPU1daSWsxLzNSQVNVMVpEYkRn?=
 =?utf-8?B?TkkyMkVKa0gxUEFFd25Bb0EwUHllK01mZGNzTDNWUnJtSTNMQWxVeVk4bWIz?=
 =?utf-8?B?aEpOdFpiU2pPNTBTSEllZFVuQnBSTFB0Y2F3T01jam12aVAycVFPeFg3cGo3?=
 =?utf-8?B?YnRackxPaUlZa0l3ckZBcDNlRS9rK1diazFML3hzNzBHT21LazZpUUhIay9O?=
 =?utf-8?B?WVkzOXR2UVBPSUw1UlRXMElUM0Ezei9FNml0R0V2ZkhyZzdBU0dySDNsTHZO?=
 =?utf-8?B?dzhwT2drdzAydk5wUExQcGNhV3FJaGQxeVoyeFJSMnRZRHVtU3o1YUpzUVpW?=
 =?utf-8?B?aTFicHM0bmptRVNaa0tRZ3FwbWtGK045bElQQzhsUWJTYkZqQmxIbmdNY3Bq?=
 =?utf-8?B?MS9CVlEwQ2hkczdjWXdDRDQ2cXI3ZmZ0YkJEQUMycElqTzVYYlhxcGxaS1R2?=
 =?utf-8?B?amhMT1NMV3pyR1EvK1ZRaGVuQjdpZ284SjNiVkxhY2l6SjZhUm0rcUxiVXBa?=
 =?utf-8?B?SFNWQXdKTGYvVGgyWUsrMEx0Z3hRME1oM3FYb3pMM2dnN2lxb3Q2Z0Fnc1pz?=
 =?utf-8?B?SHpLRjRKWllhNkk5WUFrS0ZITE9MWEdqbnlXNXorWXVTTkZGdk43cjlaOEhh?=
 =?utf-8?B?SVlrcmdVdXk1S3NTRkpQZERDYWNqektVMkhaVkdTUVVVd0NQRHU2aFVGd29G?=
 =?utf-8?B?WFQ0dzAyWENRTmZGSytLWFlhUTRBOWpkLzhHYkU2NUZRTGdFTkF0aFUzSHls?=
 =?utf-8?B?djNuSzZHUE9zMzY2L3BjLzk4dk13S3dWc0R4N3NIWDFXSzhCNUJQZ0IxSzVx?=
 =?utf-8?B?Q0V4TnF0M2VqNkROd2VGTEVWNFdDUVVqN0s5OURYR1JURzl2ZlRxOS9sQkhw?=
 =?utf-8?B?VDAvVHE1TzZoSzRjV1VHTHQ3ejBsOGZmWVlJTTlqTU5hN3A5dkF5VXJ4M0pH?=
 =?utf-8?B?QnNTNEY1NWJmZWE4Y2ZEV3NUWDBGVnJKcDlMWExhNHB4R3Y4cVZRcmtpWDZZ?=
 =?utf-8?B?OWVNRWdLMmlhK0JTZ1dFWFRad0JidVc1aVVyMHovbTJiQXI3YXNPNVRhV1VN?=
 =?utf-8?B?cStrcnZ5UDVoZFZWckdEVUtWNEsrWG9WRmxlaG9XRVI2WlJZQ2taMUlBS2RP?=
 =?utf-8?B?RE5CRFVLQ1QrektZemN0aUc5bXc2MkJ6RFF0MHRLdUZRaXBiV01DeFBvUm16?=
 =?utf-8?B?anNFUnVCTnZNdEkxMmI2ckNuMHpNaE5zM0JUdEtZY2pYanRlODZwZUFrbyts?=
 =?utf-8?B?TjI5SmJQQUpRbExCQjJnWkZlWmZRWE5QVS9QRXJlem0yalNRbzB5UXJPdEV1?=
 =?utf-8?Q?KhzEfiAKiG7lFsqUrK1guc1e9TNXG9Sfdwx1c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4378399a-6ae2-4302-3070-08deb09df0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 03:15:52.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Rspamd-Queue-Id: D040152CB31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-10816-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,anirudhrb.com:email]
X-Rspamd-Action: no action

RnJvbTogSmFjb2IgUGFuIDxqYWNvYi5wYW5AbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVl
c2RheSwgTWF5IDEyLCAyMDI2IDQ6NDYgUE0NCj4gDQo+IEhpIE11a2VzaCwNCj4gDQo+IE9uIE1v
biwgMTEgTWF5IDIwMjYgMTk6MDI6NDkgLTA3MDANCj4gTXVrZXNoIFIgPG1yYXRob3JAbGludXgu
bWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgZmlsZSBhY3R1YWxseSBpbXBsZW1l
bnRzIGlycSByZW1hcHBpbmcsIHNvIHJlbmFtZSB0byBtb3JlDQo+ID4gYXBwcm9wcmlhdGUgaHlw
ZXJ2LWlycS5jLiBBIG5ldyBmaWxlIHRvIGltcGxlbWVudCBoeXBlcnYgaW9tbXUgd2lsbA0KPiA+
IGJlIGludHJvZHVjZWQgbGF0ZXIuICBBbHNvLCBpdCBzaG91bGQgbm90IGJlIHRpZWQgdG8gSFlQ
RVJWX0lPTU1VLA0KPiA+IGJ1dCB0byBDT05GSUdfSFlQRVJWIGFuZCBJUlFfUkVNQVAuIFRoZSBm
aWxlIGFscmVhZHkgaGFzICNpZmRlZg0KPiA+IENPTkZJR19JUlFfUkVNQVAuDQo+ID4NCj4gPiBS
ZXZpZXdlZC1ieTogQW5pcnVkaCBSYXlhYmhhcmFtIChNaWNyb3NvZnQpIDxhbmlydWRoQGFuaXJ1
ZGhyYi5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWlj
cm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gPiAgZHJpdmVycy9pb21tdS9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gPiAgZHJpdmVycy9pb21tdS97aHlwZXJ2LWlv
bW11LmMgPT4gaHlwZXJ2LWlycS5jfSB8IDYgKysrLS0tDQo+DQo+IEdpdmVuIHRoYXQgd2UgaGF2
ZSBtdWx0aXBsZSBIeXBlci1WIElPTU1VLXJlbGF0ZWQgZmlsZXMg4oCUIHRoaXMgcmVuYW1lZA0K
PiBoeXBlcnYtaXJxLmMsIHRoZSBleGlzdGluZyBoeXBlcnYtaW9tbXUgY29kZSwgaW9tbXUtcm9v
dCAodGhpcw0KPiBzZXJpZXMpIGFuZCB0aGUgcmVjZW50bHkgcG9zdGVkIGd1ZXN0IHB2SU9NTVUg
ZHJpdmVyIOKAlCBzaG91bGQgd2UgY3JlYXRlDQo+IGEgZHJpdmVycy9pb21tdS9oeXBlcnYvIGRp
cmVjdG9yeSB0byBjb25zb2xpZGF0ZSB0aGVtPw0KDQpQYXRjaCAxLzQgaW4gdGhlIGd1ZXN0IHB2
SU9NTVUgZHJpdmVyIFsxXSB0aGF0IHdhcyByZWNlbnRseSBwb3N0ZWQgYnkNCll1IFpoYW5nIGRv
ZXMgYXMgeW91IHN1Z2dlc3QuDQoNCk1pY2hhZWwNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWh5cGVydi8yMDI2MDUxMTE2MjQwOC4xMTgwMDY5LTEtemhhbmd5dTFAbGludXgu
bWljcm9zb2Z0LmNvbS8NCg0KPiANCj4gPiAgZHJpdmVycy9pb21tdS9pcnFfcmVtYXBwaW5nLmMg
ICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gIHJlbmFtZSBkcml2ZXJzL2lvbW11L3toeXBlcnYt
aW9tbXUuYyA9PiBoeXBlcnYtaXJxLmN9ICg5OSUpDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJ
TlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IGQxY2MwZTEyZmUxZi4uZjgwM2E2YTM4
ZmVlIDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMN
Cj4gPiBAQCAtMTE5MTQsNyArMTE5MTQsNyBAQCBGOglkcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVy
dl90aW1lci5jDQo+ID4gIEY6CWRyaXZlcnMvaGlkL2hpZC1oeXBlcnYuYw0KPiA+ICBGOglkcml2
ZXJzL2h2Lw0KPiA+ICBGOglkcml2ZXJzL2lucHV0L3NlcmlvL2h5cGVydi1rZXlib2FyZC5jDQo+
ID4gLUY6CWRyaXZlcnMvaW9tbXUvaHlwZXJ2LWlvbW11LmMNCj4gPiArRjoJZHJpdmVycy9pb21t
dS9oeXBlcnYtaXJxLmMNCj4gPiAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0Lw0K
PiA+ICBGOglkcml2ZXJzL25ldC9oeXBlcnYvDQo+ID4gIEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpLWh5cGVydi1pbnRmLmMNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9NYWtl
ZmlsZSBiL2RyaXZlcnMvaW9tbXUvTWFrZWZpbGUNCj4gPiBpbmRleCAwMjc1ODIxZjRlZjkuLjMz
NWVhNzdjY2VkNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L01ha2VmaWxlDQo+ID4g
KysrIGIvZHJpdmVycy9pb21tdS9NYWtlZmlsZQ0KPiA+IEBAIC0zMCw3ICszMCw3IEBAIG9iai0k
KENPTkZJR19URUdSQV9JT01NVV9TTU1VKSArPSB0ZWdyYS1zbW11Lm8NCj4gPiAgb2JqLSQoQ09O
RklHX0VYWU5PU19JT01NVSkgKz0gZXh5bm9zLWlvbW11Lm8NCj4gPiAgb2JqLSQoQ09ORklHX0ZT
TF9QQU1VKSArPSBmc2xfcGFtdS5vIGZzbF9wYW11X2RvbWFpbi5vDQo+ID4gIG9iai0kKENPTkZJ
R19TMzkwX0lPTU1VKSArPSBzMzkwLWlvbW11Lm8NCj4gPiAtb2JqLSQoQ09ORklHX0hZUEVSVl9J
T01NVSkgKz0gaHlwZXJ2LWlvbW11Lm8NCj4gPiArb2JqLSQoQ09ORklHX0hZUEVSVikgKz0gaHlw
ZXJ2LWlycS5vDQo+ID4gIG9iai0kKENPTkZJR19WSVJUSU9fSU9NTVUpICs9IHZpcnRpby1pb21t
dS5vDQo+ID4gIG9iai0kKENPTkZJR19JT01NVV9TVkEpICs9IGlvbW11LXN2YS5vDQo+ID4gIG9i
ai0kKENPTkZJR19JT01NVV9JT1BGKSArPSBpby1wZ2ZhdWx0Lm8NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9oeXBlcnYtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaHlwZXJ2LWlycS5j
DQo+ID4gc2ltaWxhcml0eSBpbmRleCA5OSUNCj4gPiByZW5hbWUgZnJvbSBkcml2ZXJzL2lvbW11
L2h5cGVydi1pb21tdS5jDQo+ID4gcmVuYW1lIHRvIGRyaXZlcnMvaW9tbXUvaHlwZXJ2LWlycS5j
DQo+ID4gaW5kZXggNDc5MTAzMjYxYWU2Li5kMTEwNzZmOTA2ZmIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9pb21tdS9oeXBlcnYtaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaHlw
ZXJ2LWlycS5jDQo+ID4gQEAgLTgsNiArOCw4IEBADQo+ID4gICAqIEF1dGhvciA6IExhbiBUaWFu
eXUgPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCj4gPiAgICovDQo+ID4NCj4gPiArI2lmZGVm
IENPTkZJR19JUlFfUkVNQVANCj4gPiArDQo+ID4gICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
PiA+ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9p
cnEuaD4NCj4gPiBAQCAtMjQsOCArMjYsNiBAQA0KPiA+DQo+ID4gICNpbmNsdWRlICJpcnFfcmVt
YXBwaW5nLmgiDQo+ID4NCj4gPiAtI2lmZGVmIENPTkZJR19JUlFfUkVNQVANCj4gPiAtDQo+ID4g
IC8qDQo+ID4gICAqIEFjY29yZGluZyA4MjA5M0FBIElPLUFQSUMgc3BlYyAsIElPIEFQSUMgaGFz
IGEgMjQtZW50cnkgSW50ZXJydXB0DQo+ID4gICAqIFJlZGlyZWN0aW9uIFRhYmxlLiBIeXBlci1W
IGV4cG9zZXMgb25lIHNpbmdsZSBJTy1BUElDIGFuZCBzbw0KPiA+IGRlZmluZSBAQCAtMzMxLDQg
KzMzMSw0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaXJxX2RvbWFpbl9vcHMNCj4gPiBoeXBlcnZf
cm9vdF9pcl9kb21haW5fb3BzID0geyAuZnJlZSA9IGh5cGVydl9yb290X2lycV9yZW1hcHBpbmdf
ZnJlZSwNCj4gPiAgfTsNCj4gPg0KPiA+IC0jZW5kaWYNCj4gPiArI2VuZGlmICAvKiBDT05GSUdf
SVJRX1JFTUFQICovDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaXJxX3JlbWFwcGlu
Zy5jDQo+ID4gYi9kcml2ZXJzL2lvbW11L2lycV9yZW1hcHBpbmcuYyBpbmRleCBjMjQ0MzY1OTgx
MmEuLjQxYmY2NWU0ZWE4OA0KPiA+IDEwMDY0NCAtLS0gYS9kcml2ZXJzL2lvbW11L2lycV9yZW1h
cHBpbmcuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaXJxX3JlbWFwcGluZy5jDQo+ID4gQEAg
LTEwOCw3ICsxMDgsNyBAQCBpbnQgX19pbml0IGlycV9yZW1hcHBpbmdfcHJlcGFyZSh2b2lkKQ0K
PiA+ICAJZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfQU1EX0lPTU1VKSAmJg0KPiA+ICAJCSBh
bWRfaW9tbXVfaXJxX29wcy5wcmVwYXJlKCkgPT0gMCkNCj4gPiAgCQlyZW1hcF9vcHMgPSAmYW1k
X2lvbW11X2lycV9vcHM7DQo+ID4gLQllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19IWVBFUlZf
SU9NTVUpICYmDQo+ID4gKwllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19IWVBFUlYpICYmDQo+
ID4gIAkJIGh5cGVydl9pcnFfcmVtYXBfb3BzLnByZXBhcmUoKSA9PSAwKQ0KPiA+ICAJCXJlbWFw
X29wcyA9ICZoeXBlcnZfaXJxX3JlbWFwX29wczsNCj4gPiAgCWVsc2UNCj4gDQoNCg==

