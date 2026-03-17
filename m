Return-Path: <linux-hyperv+bounces-9476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGbWITqvuGmHhgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9476-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 02:32:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AAC2A2904
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 02:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AF6300B044
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5E337BBB;
	Tue, 17 Mar 2026 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZWl6JIdJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012056.outbound.protection.outlook.com [52.103.2.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB220221F03;
	Tue, 17 Mar 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711160; cv=fail; b=BN0Reg7gs7y4Vvq0EHdTHJVaX3nbcTdWoVVgT8IuLxVLDyEFnN8hedhb1OV6ds2Q+hm6ZcuILRqyvcXiDKLVvbcONkIb74qbI7S/pPY/yfSTaypkaYFtQotc6psoK7e/xOAB4xdIMo0Ud+dJZ9SFkXeXZIPYC2NmZ8Vv/1kdcG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711160; c=relaxed/simple;
	bh=xiuCSHNGIYpMBPogziarJ1epABo8C5WA2KBO39tf9ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4tyh5jZ930uqBMcRYEIGoryyzie3ATF+fv/vUkO9IYyOGH6ri3oD9EppuvM5pf100x79XSWS1qISRV081Wf87HlJlrH0ayJmQVUumFptpJrST1Sh3wgGrvAFXXqwgHQOjfHT239NDPy8I9iTlgDOjPzVjH/PPvRbc5Dlsbdz48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZWl6JIdJ; arc=fail smtp.client-ip=52.103.2.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEBOJ+AzReEMO4I2o1TrDShi98jdyVyutnUZ+xJteB+XlXwdN6CcdKjrkY5wK5ez6Bdp/0ytWODwpCUtH3CKfMeIOv3DC1bYaM36Jrf+/2UQbiYuchN6t74Iqku8FHS4LohS1aioURXSlOuyvwAySMUsvIdwZdEMn3Pc1mYkSUv3XrDkDjyMo1llESEeyWuli43ydtMgOOFxuoTHc8Wf3xtgXR+IhMcwDsnTl5UwF/vAzhGHpQFPBrvt1w8VSDda7zE7rBn8cLgM10jGNiPo2D+NHiIQ6U6t+dfaLP65HjZe7s+QnGaLL6OPcPhChJ6pLQSnnRcCIYTwkRWYaVqoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiuCSHNGIYpMBPogziarJ1epABo8C5WA2KBO39tf9ow=;
 b=C5+Sxq81T53YsIVIfGOxbV9da3nXlIYJ/nqX8wRYWXqt9kzxkPgROLR7TFEgbEFckmScF1pPRoHLAp5Ug5+MeZG6tUQsLN9avSkZNuUPNzZmDYxh3o5dMUoWppRMBHf/ErX6hqGVIfmEgo2z8KfQyAAY73018Fzgj186dq3xg1iFBZTUmhV+NnRIRtq3rgyJDOQ8VBbgz52mz5IvgCfLXHs+k3PfXFdnmufTkiPk7P3bawCSso36rzVU5B+KDmBs0sDHsBOsGu/CE1SZEGL4P3F2Qml8lXU+bQgVOTbf/aUKHUOn5+2hC03ebQ5rjFZsENGZtOKYMstcATMBLrdtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiuCSHNGIYpMBPogziarJ1epABo8C5WA2KBO39tf9ow=;
 b=ZWl6JIdJAL6q2WpWQIlRaWNUkPgTbZw8P/7+gryNxB56AioHIgyDhZmN6JWunSiRkqHTZJzA+dSh5OmdNBOWDV9kyvJk9ODCSHqI0pblw9m0jehJU10YMRBg0Rqp+5ypq/3BktRdXyNeQbNdXFDva0Vi3g1l9Dxscs2DtkMg/eMllufqdbjaKI+ndw7LFChZDpkhWlXdluc3CbFQ9aGUHWgZckXNpPhunDkItQrkTubhrx7uatbGmOwQle9LfXDbmPjZePN5LU2b3QnB6ww8nKyIP1ndgfypFG2tdTjCQeq02mvGHIi+tdI+w5uPY1KpGmbrYu3xbgjoWVeqTvm6OA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7908.namprd02.prod.outlook.com (2603:10b6:208:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 01:32:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 01:32:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Set default NUMA node to 0 for devices
 without affinity info
Thread-Topic: [PATCH v2] PCI: hv: Set default NUMA node to 0 for devices
 without affinity info
Thread-Index: AQJdn6OmeRuA+k0tzxDRj4WkrkXucLSwHE8w
Date: Tue, 17 Mar 2026 01:32:35 +0000
Message-ID:
 <SN6PR02MB41575613608EE66F370E0C6AD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316210742.1240128-1-longli@microsoft.com>
In-Reply-To: <20260316210742.1240128-1-longli@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7908:EE_
x-ms-office365-filtering-correlation-id: 2c06b262-83b3-4eaa-1308-08de83c51161
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|13091999003|8060799015|8062599012|15080799012|31061999003|19110799012|51005399006|37011999003|461199028|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTk2d1lMRlIycDBLNFMrSldDekVVWTlob2t6SmJmQmpYblpTeHpKZndsQmlz?=
 =?utf-8?B?SUNweU5Ld2RGbzY2QnduakRZVUZEdFU1dGJmTGJ3SWdyWGlRTEp0RnFwdVRB?=
 =?utf-8?B?MmU0QjJ3enM0U29QT2dQMmkrazVXSVhTazNGdzUwL0FNbVBEMU91ZjB2SlFt?=
 =?utf-8?B?MlJvZ3ZXNWF2ZEdFT1dtV0tkcUd6SVRNanhzWXRYRkZYTkR4YVBLQWtQV3Vm?=
 =?utf-8?B?YndnZ2ZzSjFIUTVsZy9CeEl3MnRXd2dEWEhxQXRkOTgwS2NpTnNlUGg3WDhM?=
 =?utf-8?B?M0ErejNQQ1lBNWMrR3FsclM1UHU2VEhpczZqOS9jYXA0Q0tPZTlSNVJRRncr?=
 =?utf-8?B?RWg5TFdCdElzZGVYVUt1MW9KbzdYT2pUNCtHbU53TkZiOVR6UEJhalNEczha?=
 =?utf-8?B?WkZxbGhWdHltUk9seFh3R0hXZ0FTdTBMWld1SktsazdnNTIxOWMzUEFPalAr?=
 =?utf-8?B?R3Fabno3SXpIMmZMMHVucHVxZGhxMEF0REZXV3ppNWZOUXZKTFV5U3ZySVRq?=
 =?utf-8?B?L0lmNTFVK0xIeGhHcG1sYTZHeU1KT1cvL2RveWRYRE14UEt2RUh2ZExRaUdT?=
 =?utf-8?B?TklJeVBXSFJPTlFYdi9Mc1pENG10L0k4SzlEVHdsbCt2aWVwSHB2MjFxRlhF?=
 =?utf-8?B?RzRXT24wVlloTHdocC9lOXNROGpQT3pnTndmRnJFYlNrdEJNTGtRSE84ZDhC?=
 =?utf-8?B?VlZYZjhnQzBLNHN1QUJXQytBZnRMRXRPcDVNTUFjT1BDeG9rdFM5c2cwL3Ba?=
 =?utf-8?B?dnhQV1FnZVZ0c3VzUEZvaFY4c05QT0dxN0lnM0ZBdE1iOVRYcU1EOG9Vd0N2?=
 =?utf-8?B?cGlaQlJYenYyQkpCVERjaDNMcCtTVUx4V0ovekxldisxUjJuVkQxbVU0cFNn?=
 =?utf-8?B?U29jb25DcjFvQ1cxM3pReEhNbWZFQVJsL0IyRlVEUzZZVDVETXFpNFRnWU9R?=
 =?utf-8?B?UGY2M01jcVNvc0ZET0hYVjVOQmp0TitoT1ZLVlF6VkszdTR0VHFsbTRkVzlY?=
 =?utf-8?B?YlByUUtlK2pad0UrUzd2U21wbGYwQzRYYnFPNHN5bmN0V0dwdU55NWIva1Y5?=
 =?utf-8?B?NzFQYzM5a012OSttNTBjNG1sZ0t4QnhHSGhhWFgyNDhscmlUS25pVzlNZWVT?=
 =?utf-8?B?enNySkJDUU1zN1UvRVVSYVM0U3p1THJTRTNmZWluQTRJem5wN0RYejB4Zjdo?=
 =?utf-8?B?SWZyQjg2ZklzNmdtOWtlNk51UmY4R1RrTXVTZUxza1N6ZW1WY05qVzZ5b0I4?=
 =?utf-8?B?eks2d2dyU0YwT2wyeU94VXE0SFhiS2Vybm51bldMZzluTnlCcERjeGFmVXJF?=
 =?utf-8?Q?Phxejwhj8NtjkMX1HyJko1UBBCTpGUFcL4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlJWK2RwWFEyZW5XNkVweS9pTVYrcjNIZXJORktLbHBMYWZkY0lFTCtsM1RD?=
 =?utf-8?B?c0FNNGFyOERxVmpyanNOV0xPaXAyOVE3bE1rS2NDMjZCSXYyRWFWZ0RmL1lP?=
 =?utf-8?B?djN5U1B3ekMyOFQyNXpuckZVMTFHTjJzd1FNR0k2TVFRVnhQRjlTL2MxZkVh?=
 =?utf-8?B?S2l2QUVaNHVaVXdnZkFBM3hFWVNBSUdBWFh3Sk9HbklwNXlMNXN2QkV0d0Rj?=
 =?utf-8?B?ZHJEci9QWTlJY1U1YW80aTkvc0hKcTdxaHhsYnNlZnFlenVNZHlTbDdhelhy?=
 =?utf-8?B?cGg3U1dLMUFaUE9hZitHbjAzZk83TDRtY2lyM0dGblhWYVVKcXNoRWp4MkZN?=
 =?utf-8?B?NTVNdTI0WXZyMXNEVUgzdHphN2o3cmhhemYxWnRZN0FLYjNYVjFQUVNnSjQ2?=
 =?utf-8?B?S2FPYjhuMHlkZEdtYk1XVWxjWUtnR20vVHQyak9lSTh2RzBsaitOd0FZRlhX?=
 =?utf-8?B?aWFMeXZHK244MTdXTDVKV1Iyb05xdzdiZzE2QmJrTDgvbGVURzBjdExmWjBj?=
 =?utf-8?B?eEdldVVSTDBhZnRCYit4cCtRbnZ2OEttWkJnVWZmYkU2KzkvQXovSVU4NUI5?=
 =?utf-8?B?ODRQa2Erb2tnOENVSUhIVjlBZUZPRjdXQmo4c0xHUDB3SkNLNzhUUGIrN3dp?=
 =?utf-8?B?YVN3VUM3THlHWnJpQVlVNG91YjBSSWljc2RBNmp2c21CZnM0UmhmUnQwVlUx?=
 =?utf-8?B?ODdibWhTakhrajNlSHFDTFZYcWFDc0FWTXBQdnlRbEFhNmk3QnJrd3FBWkZw?=
 =?utf-8?B?Sk4rVHYzQzJrUFNhQzhQdzVadjhDUGZvc3E4NXdSaXdtKzVsZUErYUtJS2kr?=
 =?utf-8?B?aFVXNnREMC9yUDFJaGVqN1A4Zm8ybHM3SGNiRzhBQzFjR2NQU25HOE5xMkFF?=
 =?utf-8?B?b0JubkxyaVJUZnBySTBBWXpxTHgrOXB2LzJOWlJlakNZelRRVEZJbVNQaGpz?=
 =?utf-8?B?S0FVV3RaY0taYWdEWDVzLzNua0RRY09zNHVXdU9wWmRJRENtMzBRaFZMejF2?=
 =?utf-8?B?aFpaakJBcjhwZHRoSmpSQndjaHBRb1d5TTA1N25TUkcrcGhqOXRqTkZXVFBr?=
 =?utf-8?B?Y2liN252QkVoZEZhblc2cTNTRHM5eUoyQ2N0OGZabTA5bExOWTRiMisvVWpz?=
 =?utf-8?B?KzZmdGVKaHJiOEh2UXVTaUxWMkZURTN1RzBYakdRWFR3SkpCUVovbmF1dE40?=
 =?utf-8?B?ZjJoQi9LRmVjYmVwUmpma1U3TlNIVnE1ZnNnSm1Uc0dOcXYyQ1NsWUQwWU1E?=
 =?utf-8?B?TlZpbTRtditOZDRmS3NQVnVTd3g2LzBpQWl5cUVYR0R6Vkhac29uRC9pcUNx?=
 =?utf-8?B?K2E1RlgxdlBaeFF0QVE0RWtpelVUaXhFNzQybzNrT1dWWEV2TFE5eDBqUkww?=
 =?utf-8?B?b3htSldORmRVRCtmQ2lkYncxaHNzZzB2eTJCY2ZFbEl6QjJabTlONXdLRHlT?=
 =?utf-8?B?OTNYN2ovZG1HS0ZJN2hRMmVPb2VGRmhYS3BnTk5CbUx6bVg3dTl1eXJCQ2NH?=
 =?utf-8?B?MExVZXhzcGYxQlRZb0RaZ1YySy9JUjhRSG1aVXc0Yk5EaGl6TVI2b2NvdTFZ?=
 =?utf-8?B?VXhkVG1XS3NHd0ZSMnJCaTBsNW1wMUV6V2twMW02NE1qZENQanQ0VXFTRHFT?=
 =?utf-8?B?ekhJa3V0Z0NEd1BKcUlPYnZrbHRCNEFCSk5oUFBnRFVqaVZuT0RZUjU1ejdP?=
 =?utf-8?B?MEg5b0c0ZmxlNU1PcDV0cDNXRUx5QzBFVXhmL2cxcFZGMHlwQjJkNTViOUk3?=
 =?utf-8?B?V2hDUDhsdmx6d3g1aFh6ajV2TFBsOGtIM3c0b2Fndm9OTTFFc0FhcCszdy81?=
 =?utf-8?Q?TpW5Qqs1UzKNOVe/WBwaTTjKf+1n9GCalNaY0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c06b262-83b3-4eaa-1308-08de83c51161
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:32:35.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7908
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9476-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E2AAC2A2904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+IFNlbnQ6IE1vbmRheSwgTWFyY2gg
MTYsIDIwMjYgMjowOCBQTQ0KPiANCj4gV2hlbiBodl9wY2lfYXNzaWduX251bWFfbm9kZSgpIHBy
b2Nlc3NlcyBhIGRldmljZSB0aGF0IGRvZXMgbm90IGhhdmUNCj4gSFZfUENJX0RFVklDRV9GTEFH
X05VTUFfQUZGSU5JVFkgc2V0IG9yIGhhcyBhbiBvdXQtb2YtcmFuZ2UNCj4gdmlydHVhbF9udW1h
X25vZGUsIHRoZSBkZXZpY2UgTlVNQSBub2RlIGlzIGxlZnQgdW5zZXQuIE9uIHg4Nl82NCwNCj4g
dGhlIHVuaW5pdGlhbGl6ZWQgZGVmYXVsdCBoYXBwZW5zIHRvIGJlIDAsIGJ1dCBvbiBBUk02NCBp
dCBpcw0KPiBOVU1BX05PX05PREUgKC0xKS4NCj4gDQo+IFRlc3RzIHNob3cgdGhhdCB3aGVuIG5v
IE5VTUEgaW5mb3JtYXRpb24gaXMgYXZhaWxhYmxlIGZyb20gdGhlIEh5cGVyLVYNCj4gaG9zdCwg
ZGV2aWNlcyBwZXJmb3JtIGJlc3Qgd2hlbiBhc3NpZ25lZCB0byBub2RlIDAuIFdpdGggTlVNQV9O
T19OT0RFDQo+IHRoZSBrZXJuZWwgbWF5IHNwcmVhZCB3b3JrIGFjcm9zcyBOVU1BIG5vZGVzLCB3
aGljaCBkZWdyYWRlcw0KPiBwZXJmb3JtYW5jZSBvbiBIeXBlci1WLCBwYXJ0aWN1bGFybHkgZm9y
IGhpZ2gtdGhyb3VnaHB1dCBkZXZpY2VzIGxpa2UNCj4gTUFOQS4NCj4gDQo+IEFsd2F5cyBzZXQg
dGhlIGRldmljZSBOVU1BIG5vZGUgdG8gMCBiZWZvcmUgdGhlIGNvbmRpdGlvbmFsIE5VTUENCj4g
YWZmaW5pdHkgY2hlY2ssIHNvIHRoYXQgZGV2aWNlcyBnZXQgYSBwZXJmb3JtYW50IGRlZmF1bHQg
d2hlbiB0aGUgaG9zdA0KPiBwcm92aWRlcyBubyBOVU1BIGluZm9ybWF0aW9uLCBhbmQgYmVoYXZp
b3IgaXMgY29uc2lzdGVudCBvbiBib3RoDQo+IHg4Nl82NCBhbmQgQVJNNjQuDQo+IA0KPiBGaXhl
czogOTk5ZGQ5NTZkODM4ICgiUENJOiBodjogQWRkIHN1cHBvcnQgZm9yIHByb3RvY29sIDEuMyBh
bmQgc3VwcG9ydCBQQ0lfQlVTX1JFTEFUSU9OUzIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMb25nIExp
IDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MjoNCj4gLSBSZXdyaXRlIGNvbW1pdCBtZXNzYWdlIHRvIGZvY3VzIG9uIHBlcmZvcm1hbmNl
IGFzIHRoZSBwcmltYXJ5DQo+ICAgbW90aXZhdGlvbjogTlVNQV9OT19OT0RFIGNhdXNlcyB0aGUg
a2VybmVsIHRvIHNwcmVhZCB3b3JrIGFjcm9zcw0KPiAgIE5VTUEgbm9kZXMsIGRlZ3JhZGluZyBw
ZXJmb3JtYW5jZSBvbiBIeXBlci1WDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2kt
aHlwZXJ2LmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiBpbmRleCAyYzdhNDA2YjRi
YTguLjM4YTc5MGY2NDJhMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaHlwZXJ2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMN
Cj4gQEAgLTI0ODUsNiArMjQ4NSwxNCBAQCBzdGF0aWMgdm9pZCBodl9wY2lfYXNzaWduX251bWFf
bm9kZShzdHJ1Y3QNCj4gaHZfcGNpYnVzX2RldmljZSAqaGJ1cykNCj4gIAkJaWYgKCFodl9kZXYp
DQo+ICAJCQljb250aW51ZTsNCj4gDQo+ICsJCS8qDQo+ICsJCSAqIElmIHRoZSBIeXBlci1WIGhv
c3QgZG9lc24ndCBwcm92aWRlIGEgTlVNQSBub2RlIGZvciB0aGUNCj4gKwkJICogZGV2aWNlLCBk
ZWZhdWx0IHRvIG5vZGUgMC4gV2l0aCBOVU1BX05PX05PREUgdGhlIGtlcm5lbA0KPiArCQkgKiBt
YXkgc3ByZWFkIHdvcmsgYWNyb3NzIE5VTUEgbm9kZXMsIHdoaWNoIGRlZ3JhZGVzDQo+ICsJCSAq
IHBlcmZvcm1hbmNlIG9uIEh5cGVyLVYuDQo+ICsJCSAqLw0KPiArCQlzZXRfZGV2X25vZGUoJmRl
di0+ZGV2LCAwKTsNCj4gKw0KPiAgCQlpZiAoaHZfZGV2LT5kZXNjLmZsYWdzICYgSFZfUENJX0RF
VklDRV9GTEFHX05VTUFfQUZGSU5JVFkgJiYNCj4gIAkJICAgIGh2X2Rldi0+ZGVzYy52aXJ0dWFs
X251bWFfbm9kZSA8IG51bV9wb3NzaWJsZV9ub2RlcygpKQ0KPiAgCQkJLyoNCj4gLS0NCj4gMi40
My4wDQo+IA0KDQo=

