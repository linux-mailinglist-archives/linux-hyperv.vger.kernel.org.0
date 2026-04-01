Return-Path: <linux-hyperv+bounces-9871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDZcO3FOzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9871-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:57:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A918A37E452
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED972301E7B8
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15303DEFE0;
	Wed,  1 Apr 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QlwvUqv7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012080.outbound.protection.outlook.com [52.103.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B63264CB;
	Wed,  1 Apr 2026 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062503; cv=fail; b=pRdgsAeToPA5tNbd4rpXDSxlQDAH9+QLA7HuSsjQibg00tJgqBv+t1RCP3YysDj5bc6w4Yi4wjgNsGd+5kTfHvC4kYwN9ZnPanqIYXsaQwtY2wYiI2zkC7FkKNWIG0s4Y33Z4n/AtfZ59nWStflZ2fKMajo0nUc8RCSOgAmiL8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062503; c=relaxed/simple;
	bh=1HO4eevxWkc3qfaRQ4rpK6ENiijgM93ejP/WW4FJg5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LyK6B1k5G7t/zaZO54XSKTfFIJy/VHdxFmiwLTp9+VJyPvgQkdNxe5qViCKRlDojbY3Tc2AqE/VtmiAdcQiFaPLPLbUH0KnwJ0g9bNS/9dBM3DG5jhmWn29NrHTrTnZZrmjvhd+ezbSFDQrHcXAI9wLCQ/Qg4B4zbitP9nNUUAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QlwvUqv7; arc=fail smtp.client-ip=52.103.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl/SmAOACCAx2H5eJCeViZrMRV8e+EhQQMi0bm3NfE6xM0B1JBfIwsteD5/dYYZ6CsIDzJkD0SyERv5uiTFQy6TcBqynRGTVGGlaLpaMoyX/AAjGfVFz1d0kSOcZy5ymuCV0EC9V2nh5ZS9+vk1kUFCDEvCUp9PK8TYBJUM9GpkhNomWrr+3xnM7meQaeurRxqrV0GArkB1bNaXC5E9ZZJ3apremjgZsFICT9AQh+UCZvIHNAottiAsPT6DBMDaR+wdkCiGyEf0Gg95FfFfXB0ZlZvaxeXtdDIugKqDnjPCnLvU6ORsKg0pcF6wXd/YcaQLcfqGl8MNoCIemEZsukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ritCHsA/eLYR3EGweodEJnzJadd/QkugcIkMpQry5Bk=;
 b=xTfmFJ60tgentXAfUC9sxS7B54pOABO/OB1kDUQgm+kKcf13Mx640WQQW/ASW2jMo7QEys8Lc1ot2gxM8IGNpo27bYnrotMIZF8gYqu7jHeojuKrlc4VkTSrg7FaXHDDBsjaM0Y5DVyB2EJDllnZQaawy/v40SKYhLv4D4sThR2/liACDI/FLxIAho59NjhoQGL942ZWw4ajFrci7UPOUROzKLYhDI7kEfyFesWh4Kzqtl8t0dM19jZ5pTp61SPI/uigfBR0WuTIPEZw4FA2z3vPLxIIz8Gsfl3xI1hpXWpbW4dOGZTw00/8cmz7PH3XKvfweQ6T4FUSXDbq0UEIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ritCHsA/eLYR3EGweodEJnzJadd/QkugcIkMpQry5Bk=;
 b=QlwvUqv7NJ9jH/1vKMSpEs41Mvs/OOa2FTg7QK++tnphOOvlXaQMEPRXnR6uVQ6dEZxvUUhDi/oLoyZcuGKHINF+9muSKaMfzxEwoyQui3lToRh6KJnvJENXgSkVDn5qVajlPxQTY1wF9GBoaz0zkhlQKfux1ZV8RhQH1I3KScSnhnBCa+8/CltteuAmuvurLUKiQifyCWBsXjuIVPzooqUUvO5FrXRddc5g0WeBHMPckA3XgjF7SvWO8xsUlW+vRqb+VeA5vkMxjWeib7IWTuUulsXg4ZjHEcOhB6T4rtLXJY0k8gUELNpnsQpyWO1uvLCS8USS5ukCapbz3hx7DQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:54:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:54:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 01/11] arch: arm64: Export arch_smp_send_reschedule for
 mshv_vtl module
Thread-Topic: [PATCH 01/11] arch: arm64: Export arch_smp_send_reschedule for
 mshv_vtl module
Thread-Index: AQHctT5EbNtOyKWv/EOiHTab61OuerXKhg5A
Date: Wed, 1 Apr 2026 16:54:59 +0000
Message-ID:
 <SN6PR02MB41570A9050B3EB6A905DFF56D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-2-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 0441daff-219a-43bd-5eb0-08de900f690b
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmnDmlsl/vneQbmorDq9Hf2UGMXAmyq6JbocoBh7E6vmXsoAzvGNPbipTcETE3dUY9RcTaxTpvxRyUJEOlYQm+LYOSLBgVt5+GjVelHCZ6ksityk6n+GcVIcHWgvnz+lk4Cli3WKy4JJfF/cCjFtq+zNkqu34t2CH1AZkyfjKexkj2HZ9ls/j/La7GA8o7OQKy5fzcUq24R41e+FL4ewUDPKiq60r81lCsBZ66YIHnf/aN7TYfGN6JgI+JhfmpUrTF80Lf4+gmdTo3q9gbj57tLrCg8IsW7UYpDBOJ2GDHKLltzgfg6kEV1SHsXLRMWJziFXuP63OVg7ZofOIT3z75cHnTyt0L1nVCkYh6BqgW3Fn8d5JEBgyCV8ln/sII3XTHWzTWc4UBTrAAYSFO4XS33M47xNG0zbMNdN/0vCJZPS/glUL6PYRfpr35bGDSzthdFDHQxQw4v2i3HrcR/ETSyOrjlGSmqPLuU7kryqopuQj/mJzeGdDvqOM1upbj91jdm+cHDHQqMxsifBAZ+5pGs7hB5n4YurpzdYcIF30UkP1zbyR7DCB/QKrs17rtQ1zzcqSGQKNDkoBixHiOKYao76vBYcY+whfjEARy54POUxuFEx7IOJIW1Z3xoUBiSLe2vmJFn833yCOOEvhz9hQVKGbTRXulRIAD3nKOmZ3wFwaDSWzctFfbWgNw+G6PxJ2ayLwi1FdQ7Ws+R6WDyM1cFWPQt0dhfYw0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|26121999003|102099032|13041999003|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oWz92/C1edlgqAYLHz+IYSqz+C2H1Vb6jhArZBeiMhkwiloyt7slKI4qZ4zl?=
 =?us-ascii?Q?FpkMSRCbhM6ZpdsLC9J7mQGpoI4IS/zNDhvpX7IqO+IXqlHykSqCMSN1NtjS?=
 =?us-ascii?Q?nW7wwZ1PzlpQQhncgW2LSIhKUXhLJ7HyoTrbkjAjmdcE4skCKNPVAUJ9kgkb?=
 =?us-ascii?Q?2JIf6Go3RlBylIEGPEcHgZF6j8VeOUsVno/H5o6C5Khe6xR1MujC98QeyFt1?=
 =?us-ascii?Q?ubYoshyJDQuB48kvwTaSv8owQCM22fG0azEqa3RwEfIFsJeFWre7ea95CUaF?=
 =?us-ascii?Q?HdjpZl9N59AR6/Ui8TfO3EoDpelNQZMf32uyQiGw3NEduvZMIOYeLl+i5tha?=
 =?us-ascii?Q?hZBZPpYiK74XLCbFnrrhIyYy4ynYqrwBPm2QXb7ztNToYxTdNvh85NT/g+Nb?=
 =?us-ascii?Q?q5vx3+2X1BKKjeTTILRyNxdFUKwmWaGamYAeu5Lfv0RnrAZfTQ82ReCOPIxa?=
 =?us-ascii?Q?kbtDOLNSYWWJXYU3VpzhVS7xdGOjoLMhIrARHuuqnjaNWPNZs5u+B/py1i97?=
 =?us-ascii?Q?KsFRTXZdXdrtiITxCuuXJIIzmB76xSIEai6vPX0yWaPpuon+BY5ySFxE6+ti?=
 =?us-ascii?Q?B377/96TYEdK34/XC3wwJFzBRRkIEIwkXpcAdXKYe1Scd4bCFkxliysKmC0K?=
 =?us-ascii?Q?AIxv5LlcDBNw9cCOxU4Qyhdmi+f0/GzM4fOCmZBnaswGoNH0Jx8f9q6fkRlT?=
 =?us-ascii?Q?H4NUWnMjRSXdaZBZQbAa5bn9mi+R2A+C2DSNIL9LfueFr16SoFoEa8G2Xnjf?=
 =?us-ascii?Q?TjAs2b352uTsillwM5y+9fJCszDZFyL0ANgbx7H+1S5dSuW+moV62d4jvM5P?=
 =?us-ascii?Q?o872Pluio3uYA+oAx3Zoq4xDAUJEm/jaYpvNvn5T33Hcnql9aJUEaVbFjR6M?=
 =?us-ascii?Q?yFyYyyyR2y7HaXI5J+xteBYA/v3UOxfWi2SSzOwCniosELQ1zV6Noc3nwRq0?=
 =?us-ascii?Q?GkDHZwowFv4ajt0pkrWn5LgQP9JOOcbdp7rz4m7jso9bCgpmspZrhhhV1odQ?=
 =?us-ascii?Q?ySeCMWa2V2Vg7DlWhxvAt8VV9gDRNt8WhP1L9w/wDhvIFwZKECxE231u4IK7?=
 =?us-ascii?Q?3CWTLV0lBvkPJTXNF1wdiQSO50R14IweCo/zOGAK2DRtOBP3lTo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VPaXk+dmcfXbBvL3Dl6sIkWtF5EdF0tyG9aOyR1+bjf7QmTD5cIf6Gu2WWJz?=
 =?us-ascii?Q?IRMPiTyaEolPTTwHINp90QBmGZW4LSwpR0f1DiBtfpHrhRcugSjGhwMzxu8z?=
 =?us-ascii?Q?VhUrLwjxZEO9e87NFuttFQoFQKt6hRNR7kjz3WN88GDwOwFALZg840AmVhTM?=
 =?us-ascii?Q?J99zFeLy6Fi0TffR18yvjLGtbS8b0pNvTZ7VCzsrprYw/tBZxeCDgcGPXB82?=
 =?us-ascii?Q?cuaaZEqHO2UJm54AQ9nnrv708WuPGKfvzvluGhv0h9KORHWBWwC5wNKU60NV?=
 =?us-ascii?Q?nwhqmFxeaiNG4tgjKGiCQxRp9JQzWIpRWK6ThmK3oB1ScxpWQdusyyE3rKcf?=
 =?us-ascii?Q?m5d0S/6IJ42FrsV9NthFTn/lsxchxynkR+lNpi8euBSgW4SrPhisIXHRZnPD?=
 =?us-ascii?Q?Gexo1gEvHmbrTyV9T/ko+/++cBr+J+C1siNEAHiYOFyxMxZmCOUuc0QkgRWb?=
 =?us-ascii?Q?h8KY8BcqbVuM+s5BckGhLxomZOvq5NFfirzfybXgSqO/hvzibEpOHhKYuJzu?=
 =?us-ascii?Q?kunAHPM7z2W8gZo/GwcNw1viB384X2nexAU9AiwckR7IMs2UqDwQC0UKWspW?=
 =?us-ascii?Q?aYzAtQnhcxCxuHyEVzqM8tXHkH+3EbJhkwFFjY5JXbV1wt5cv/vWze1OB3gJ?=
 =?us-ascii?Q?97iaUoRTEtThozM+nYRnV1qV3s0RzalXRnCN4Kq5RfoGK3wxMY60aRe3bFmi?=
 =?us-ascii?Q?4Iuqph3v9Lv4SHKfafA8R3HP4lGPd1tiw07LA79vcy5PQpou4++arRGmNYrN?=
 =?us-ascii?Q?xNweQhk/Tx9iNLDojKxbwSNndggZ0/dSOateUxHmMjO3zl6oTCWm+Voh7jUR?=
 =?us-ascii?Q?ps+TlgnrmePNHaMc2I7Pf7F7A2aC+CPrIlblB0F9SQe7ZtZomei2oIdgWI3S?=
 =?us-ascii?Q?7OnK5NG3DvIWvtMQvlOMZrtCEmxJRuKC4VLmFpVv3gk3f60aNakTjjkq/U8Q?=
 =?us-ascii?Q?auUC8bQeFkbtX+V3llz3ZISc0hfzcEtOC2NBqhTo3KOvuAyIuadZBPOpclcF?=
 =?us-ascii?Q?uhvfWVyJw4Gx0ggJeYvgo1xxmmmoDeHJvQzq8eX0v3/QcpW/bPdPzKnAGMFT?=
 =?us-ascii?Q?gvhrkpLjfboy8ufmBpHvSya1VcunpQSOkPC/HFN9HfcIunujgV0Bq5PbWHE3?=
 =?us-ascii?Q?DXto75Q9k5cHnFybeeDiwbNUeZHQ6Phs1qSJmn8uQcNWBnAlb0PpmVIn4xrE?=
 =?us-ascii?Q?hQZu/jiJdj0FUtSniEqk/wBHwdt3/8/UeuvGSjFUn5d/+neDFFJC7lwsLZ1c?=
 =?us-ascii?Q?RbINc3ifTfhuTqWTeMXJWw8V1LUh5tbHQP1YeIA2TXIDj6U45a14WCJDl9lX?=
 =?us-ascii?Q?QKRNXVSkQubm6b3TctkRIetBgQuMYtdMwS0gEcsZ3YFPqQFsSWbiobWKdiYm?=
 =?us-ascii?Q?pBl21r4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0441daff-219a-43bd-5eb0-08de900f690b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:54:59.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9871-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: A918A37E452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20

Nit: For the patch "Subject", the most common prefix for the file
arch/arm64/kernel/smp.c is "arm64: smp:".  I'd suggest using that
prefix for historical consistency.

> mshv_vtl_main.c calls smp_send_reschedule() which expands to
> arch_smp_send_reschedule(). When CONFIG_MSHV_VTL=3Dm, the module cannot
> access this symbol since it is not exported on arm64.
>=20
> smp_send_reschedule() is used in mshv_vtl_cancel() to interrupt a vCPU
> thread running on another CPU. When a vCPU is looping in
> mshv_vtl_ioctl_return_to_lower_vtl(), it checks a per-CPU cancel flag
> before each VTL0 entry. Setting cancel=3D1 alone is not enough if the
> target CPU thread is sleeping - the IPI from smp_send_reschedule() kicks
> the remote CPU out of idle/sleep so it re-checks the cancel flag and
> exits the loop promptly.
>=20
> Other architectures (riscv, loongarch, powerpc) already export this
> symbol. Add the same EXPORT_SYMBOL_GPL for arm64. This is required
> for adding arm64 support in MSHV_VTL.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1aa324104afb..26b1a4456ceb 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1152,6 +1152,7 @@ void arch_smp_send_reschedule(int cpu)
>  {
>  	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>=20
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>  void arch_send_wakeup_ipi(unsigned int cpu)
> --
> 2.43.0
>=20

The "Subject" nit notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


