Return-Path: <linux-hyperv+bounces-4358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1557A5A502
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 21:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EBA1885EFE
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150D1DE8AB;
	Mon, 10 Mar 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PLHsuYbu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010018.outbound.protection.outlook.com [52.103.2.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EC1C5D40;
	Mon, 10 Mar 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638825; cv=fail; b=OOz/wh+/1PVZE4TUzFsKSc+u9BpTwgNzuK7CjY5HrWPdrzaYWpGzlTB1JgQ2yqgIf7Gl8D1X/Ds+/bt7xDTfQqkGj3+b6L2ETzoI1ZXzslwlnoerqPrVPFq+oaYP5XMXljn0avKE3jcHHoP4VmVKOrU0mtvZY6SQF7e6WWcEKzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638825; c=relaxed/simple;
	bh=pc4mpu+LVDbwMfudDZJPKQJCC7hmNclLDH6rcVEn+7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u78Jgd1/l0YE8ZUmJfuJq4G4oXMzSA9NL+Z/YDhhkhPJk+Hn7MXJLaIu3RRBWKd3RS4lVQueh7yEuSmi55PCAuNIoAF7X88J1uu0SPltjfEcCuWv1eu15PYzGKUmLnp6S9oIkyDrrkidRVhUwr/DMhp9Hau+wqwOl7xGtfcvoLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PLHsuYbu; arc=fail smtp.client-ip=52.103.2.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZd2CBZkSk68OANBXzLr0uUSrLGwNv/Q5xnH0fGGgkYOZFKRgWx/G+38IQwwkhJPuZ0X++h0HTEsumzYc/9wpEWr4fmYuBcEEGM093QZf0QXzZzDNjV3B4BsfEhRgqInTxTbr2RODcuEQiJBvsRe7Q0QlOrBdIMdXjpkPPkSxM93+X5JTum2Z914xb2T9UybXPG9ocB8V4N/cVTCLkb6ruiBZGc1voC8vRnHQek9Uahl08izpiXRnZocDk0BU4QpxzTWxP7gXE3nzBLjyfVbnsu2yGav3qBMqBEOX95AqGgiUWpMOf0gR/mRXtH3oXQ+sNjWGXXxfg+ZtUYhhXpE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc4mpu+LVDbwMfudDZJPKQJCC7hmNclLDH6rcVEn+7w=;
 b=kOAkl8plIjD3MSutJlu4HXc+YW2MpE8T/op+3CStIOmFYlk7d0IeVhtkXQyQCI7tpB0FMFkoxpH2TF+mS0PDafEkkUhG/OUJXGEHFBhvoC+Rskc19YXmafS5RQ5O23TWKeVQN+l6WT+GFxLc3eiB6cYFI5n8i3jh4fce9jtqADoI85ygi8BFGAvr0L4TkoqTGZ2SBpiZvqdoHQt1GX/p3livB3BFaG/Z9i+sjS4y8nwxvNERGoKcNaw88LSm+e0yL1vOofoUp+oP5C5l/SQifLleDah5QSh0SSnmYqQKvz6j8OrMeZVR7OdL+t5FeFRN/aZR1jXwZ08Tx8Awlz0noA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc4mpu+LVDbwMfudDZJPKQJCC7hmNclLDH6rcVEn+7w=;
 b=PLHsuYbuS6qPTJg1RQYpsZP5Xappn+1hkRzO+W/ygPWepkNbw/wghA9o8/W9jI4kR4iTJ5JgNNRClZlhzyO7oFxBDF1ANvypB/dOciIQsp8i14fSWdbwAsQN/zEL6MNp37vGDxGJkZeEsd6kH975MZtzk+UvGT6dxVpJXIIUoZvxYqZ9z0ZV7KUSqooHqwpa+ppdk6xqkflOINldzFVgfLT0CZXfRGMpjrWQqTxGY7Vy8QbYO+AOhM0+sSq8m58DGAN7yCS8IibPOI6DOIZWdCsS+7TTt23xKuZtlslewWWv/bZqs+5Lcd6Z36SyiXjGWETFkC/V+OnlBCtiLZkNhA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH2PR02MB6950.namprd02.prod.outlook.com (2603:10b6:610:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:33:38 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 20:33:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: RE: [patch 06/10] PCI: hv: Switch MSI descriptor locking to guard()
Thread-Topic: [patch 06/10] PCI: hv: Switch MSI descriptor locking to guard()
Thread-Index: AQHbkM9g32gowDkifEaQdpg6nh2IgrNs1WcA
Date: Mon, 10 Mar 2025 20:33:38 +0000
Message-ID:
 <BN7PR02MB41486406B36F615851374654D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.521468021@linutronix.de>
In-Reply-To: <20250309084110.521468021@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH2PR02MB6950:EE_
x-ms-office365-filtering-correlation-id: fd425d36-7fc4-4b16-4025-08dd6012d6e1
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|15080799006|19110799003|8062599003|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVdCSUwxb0o0TU5SckxhL3hqWjE4c0hySGVHV3p2RlRJNTFTRTVzRFB5Z1Uv?=
 =?utf-8?B?VjM3RWpLMmxrYXQ1Zk9aUTZzeVdMV3JseDBuSzNRemVnMDV0Q1o2d2hhMCtV?=
 =?utf-8?B?cEwwTmVKZ3FWUW9adXdUbVFQRnNSVTB2U0FLQXlOOTNNRTNmbGZkcFJvUDRv?=
 =?utf-8?B?MGNnbEV3WThlTjJlZGQ2TnY5OWp6YUQwSU01bGdyRXBlaFpmZGZhRHdSaHZy?=
 =?utf-8?B?ZlRkcEJVWVhWR1d3OTA0Rnp0ZldkeXN0aVZ5WkFyV3R6cFcrVFJNWHphMllR?=
 =?utf-8?B?N1diSzRJbWp6Y3M5OGVPbndZOU1Gd3U4bnA5ekg4eE43MXpoQ3J1ZGlIWmdK?=
 =?utf-8?B?SVBzbDZ4eEFYNkV3K0xNc0xZWkVlOU8zTXM4eTIyVm5UUnNJaEdVdTlsTmRK?=
 =?utf-8?B?MFRtc3NWQU8xWUNpTFU5UFc4cDZoRWJNWU9YTk4rZERtVTRXUEhKK0NKSHFB?=
 =?utf-8?B?NVZTRzNSRGgwTUE4RGh2MGh5VmVWZFVsTGtSRk9UMnVweERTR3E3N0ZlcVZw?=
 =?utf-8?B?cFF4N2YvY2xaeUxyTHllYWtqWUpyeDlPSG1YZ3JmMmdud2NOTWs3eFU0bFdv?=
 =?utf-8?B?Z01GcDNNYVBhd1FTZlgxSHZhSzVYTDluRk1lNzgxcHNHZUtlbVMwL3JsTEQz?=
 =?utf-8?B?ZWhvaHJNUDRVZWI4Nnh4QkRDTkZlN2tNUGUrOWlPOHlHKytrVzlUTzdOSnFw?=
 =?utf-8?B?MDNodk83TjNVNXRvakZja0V1R0c4RThnNGwvVUVOc3pwQlc4UlY1NjY3SnpR?=
 =?utf-8?B?cmxJRmxUZFoyV25TMG1OejVNQVJKdkxCV0hLU2x0MlNKblZqN3d3OTdCcjFi?=
 =?utf-8?B?TkMrRU13MklsVkVYd0NNaFF6SG9aVXlUayt6cWJKMkZEbkk3bUtOMEhEekpa?=
 =?utf-8?B?c3FkVDZqRnFINW1XQm1leHhVaUxoOXBDL3o0QlB3YlkxSWlzaVc4eXd6dUFz?=
 =?utf-8?B?N3hOaWhPQTRnb1ZvMUVjMys1a1VDMC9jUGdUZVpSOFdGS0lCRE9UM2JGQU9x?=
 =?utf-8?B?dDNGUitCUTQrVkM3ZzliS2R6alU2UGVWVE4ydWwzN2dxbDdoU0RvTDB6RDlR?=
 =?utf-8?B?L2lNTWlYRXZ2WlZQRkhVS2VESFBmY0t0TmxsT3dFSExoTEZoRHBZR0N2Ujgv?=
 =?utf-8?B?UzRrZXlpY2dYZjNFblkzR002akxxQ29KSXhlbDlKWVN5VjRHUG9iM3J5TEZq?=
 =?utf-8?B?UFg3LzVBVi9pUzFQN0o0VkkydlU2NHIrU2RNV05XRHVTQkdad2pLcFhUczV3?=
 =?utf-8?B?VTluUi84Z0M2U29BZ0VVUkVMWnpYRlkvWmhSUVlWajlsZUNZNzdHUDNIRkdl?=
 =?utf-8?B?T2pXSm1RZmw2clV0MDlmaTVtazNod0pMRE11SXB4d2EyNTVWYUV4UWFqU290?=
 =?utf-8?B?TnVmYm1NSUtFeFlRbndyTUF6TjVkMXlrZE5vQXBBYlZaMWYvS3hGdFRVNG9T?=
 =?utf-8?B?cWlJNk9maVVVWGdxa1NNeWpKY0x5QTdpbUNNc25nPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGFaQ0pYMEEzWlFRd1RIZFVzaDJkNThZOXdYTUpTcWp0ZEhsRTJZL0phVUw3?=
 =?utf-8?B?U3dPa0pQT2ZWVzVBWUhPQjM5T2U4RFQ2NzRVUW1CUmJ6UE9wc1JiY2dZMU4r?=
 =?utf-8?B?Qkx5aHlMTHlkYytTeVJuTmZFeUVBTE1YNlRpN2Z0M281cjJzL1p4Tjc4U3U4?=
 =?utf-8?B?eWIwKzN2MnhISTdXRHJZQ2xZZU43U2VCOGprSys4eGJHWjJQQ0dPQ2Nxamtp?=
 =?utf-8?B?RHU4cURpOFpFemhtUkpZZ2RhSllPZHE0OWZ0M3hYY1Q1QURBR3FGY05sdm9m?=
 =?utf-8?B?YTVNdkdlRzEraXErNE1iNlR3MWc4RDJIeHZwU1UrUStGZEs4N083bnp5bzN0?=
 =?utf-8?B?Mko1VkVoK053MUw2RmhpbVM5cFdnNm5lZXJhT1JTSGdxUnptZmFhWVdlM25D?=
 =?utf-8?B?ckZBL05hNEs0OU5tY1dVUFpPSUc3L0ZDQml3c01YWEVBemc0VFJkUFJ6alNQ?=
 =?utf-8?B?ejBaZytkYmVnR1luZ24yYjBjemRSbDV0VDFPZkFwNGdJNEZpelYwQzRZQmgy?=
 =?utf-8?B?U2tJLzdDVC9yZ1BwaURnWkNLS1FxbVhRZ1RlVDlGMmhMT2JNc3U3WGdTQmdx?=
 =?utf-8?B?YmdLbVZ0YzBPRUMzMGxzeGVpemFERGtTbmFPRkpXQ3BUbFJjUkE0SUwzSERj?=
 =?utf-8?B?aGpYRjk5YzFpZ0FvSnFQeEJBdEV3UEtPYXJpZDN6YzlEdm55dVIrTmcrQkVl?=
 =?utf-8?B?ZzZQZmNweTMveEN1RktXMHdYMzBSdTBUaEtjYkF0bXlqMDhjVHR6alk1Vi9z?=
 =?utf-8?B?ZmJmRjgyN3NUbGtWb0pxUzlVQXZiWjl0b1dVZmtvSFRxN0tGdk1neldubkts?=
 =?utf-8?B?SmNtbFQ0eWVuSnh4dFJMSE96aW1GZFVySmk1cWh4UTBMaVZjYk53dUw5d2tT?=
 =?utf-8?B?Q29YVzdVZzlXc3RhMWFwM2hYWjN4bGxTVnBzRGhCSHkrUFhIOURGTlpqeENK?=
 =?utf-8?B?UWM0S0orN2RCRTV0MWxJMW96VnUvSkE2WmZsQjkxTm43ZUY5QnBnODBLZElZ?=
 =?utf-8?B?dGRsblZoREpXQVBpUG0yVnMzNm4ydFNSdDBqREZoaXNoRldnWUpmYy9ad1Vy?=
 =?utf-8?B?OTZxQkhiKytka2ZZUmFPZ1IvcEJISmxTOE5BYzFaeDMwWVFsdWJSOEJXM0pW?=
 =?utf-8?B?amR3N2F2RjVzOURKUVF1VXJnME1LQXdYL3FDclRpeDViVjNzdWI3TzUxTXJy?=
 =?utf-8?B?UnNuakZVSWFRb2wzN2ZWSjdPSk5qeGVtcXRsclRNYVYzWmcrNWhqdTFJS3NR?=
 =?utf-8?B?WFdrRTNKNkt0aEhabm4zb0M1aFpyRjZxdzJUckZKRkRhNHlRSENFL0UyUFZZ?=
 =?utf-8?B?b1FaNWZ1OHpiMTErVE5DdUEzUnJrR2ZPUHR2UVdTMlgzRFJCYk92RTRQeGVQ?=
 =?utf-8?B?WkREWXZRZ3RTMWczbHFYbXlpaEdscVhMVjI3UUpsdENscXVZRUR6dGtWeTVN?=
 =?utf-8?B?R2kySVdhWmVCQi9vaDBtOFBhcjdBamNDRU54TlFTWE9vYWVZYmltNDdDZW9h?=
 =?utf-8?B?SnNsU2hrVXdsRU5OSW02cDQ4YVEwWWtYV1JBeUltVSs3U0lhWFJJOEZVQUMy?=
 =?utf-8?B?dGVqd24ySFNBb1lUUUUwWlpRRkhyZzZjMVZlYk9TUEFYdW45QWpyb0oyTmZT?=
 =?utf-8?Q?Dh/tmLjBMpqohr4j26f0BhamNaR2/siUHEbmOJAzzUiM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fd425d36-7fc4-4b16-4025-08dd6012d6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 20:33:38.7026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6950

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IFN1bmRheSwg
TWFyY2ggOSwgMjAyNSAxMjo0MiBBTQ0KPiANCj4gQ29udmVydCB0aGUgY29kZSB0byB1c2UgdGhl
IG5ldyBndWFyZChtc2lfZGVzY3NfbG9jaykuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBp
bnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPg0KPiBDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4N
Cj4gQ2M6IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMg
PGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IENjOiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2ktaHlwZXJ2LmMgfCAgIDE0ICsrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+IEBAIC0zOTc2LDI0ICszOTc2LDE4IEBAIHN0YXRpYyBp
bnQgaHZfcGNpX3Jlc3RvcmVfbXNpX21zZyhzdHJ1Y3QNCj4gIHsNCj4gIAlzdHJ1Y3QgaXJxX2Rh
dGEgKmlycV9kYXRhOw0KPiAgCXN0cnVjdCBtc2lfZGVzYyAqZW50cnk7DQo+IC0JaW50IHJldCA9
IDA7DQo+IA0KPiAgCWlmICghcGRldi0+bXNpX2VuYWJsZWQgJiYgIXBkZXYtPm1zaXhfZW5hYmxl
ZCkNCj4gIAkJcmV0dXJuIDA7DQo+IA0KPiAtCW1zaV9sb2NrX2Rlc2NzKCZwZGV2LT5kZXYpOw0K
PiArCWd1YXJkKG1zaV9kZXNjc19sb2NrKSgmcGRldi0+ZGV2KTsNCj4gIAltc2lfZm9yX2VhY2hf
ZGVzYyhlbnRyeSwgJnBkZXYtPmRldiwgTVNJX0RFU0NfQVNTT0NJQVRFRCkgew0KPiAgCQlpcnFf
ZGF0YSA9IGlycV9nZXRfaXJxX2RhdGEoZW50cnktPmlycSk7DQo+IC0JCWlmIChXQVJOX09OX09O
Q0UoIWlycV9kYXRhKSkgew0KPiAtCQkJcmV0ID0gLUVJTlZBTDsNCj4gLQkJCWJyZWFrOw0KPiAt
CQl9DQo+IC0NCj4gKwkJaWYgKFdBUk5fT05fT05DRSghaXJxX2RhdGEpKQ0KPiArCQkJcmV0dXJu
IC1FSU5WQUw7DQo+ICAJCWh2X2NvbXBvc2VfbXNpX21zZyhpcnFfZGF0YSwgJmVudHJ5LT5tc2cp
Ow0KPiAgCX0NCj4gLQltc2lfdW5sb2NrX2Rlc2NzKCZwZGV2LT5kZXYpOw0KPiAtDQo+IC0JcmV0
dXJuIHJldDsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gDQoNClJldmlld2VkLWJ5OiBNaWNoYWVs
IEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo=

