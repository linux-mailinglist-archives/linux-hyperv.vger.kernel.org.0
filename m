Return-Path: <linux-hyperv+bounces-7048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABCCBB2186
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 02:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E00420609
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F12F5B;
	Thu,  2 Oct 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XLdGrKRd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012074.outbound.protection.outlook.com [52.103.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1C34BA2E;
	Thu,  2 Oct 2025 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363284; cv=fail; b=FVlzq13f6Z7TkuwWXZcV1PFArwPW+a8nWQ2W4NByjndQHZpHUpjC+oEf/RpgrX08urEDXwb5b6dj0nrAl+cVj7aTJXroi03vgbSh2pP9utSHRjTmYNkQLKIElBPUG3u3lc5FEDP2rpVLPCZMaF2fPpgU+e572uCfs2mo1/LgRnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363284; c=relaxed/simple;
	bh=HrSYHzB4GW2sLJMaOp2oo3GKS0xvtKpmu2BHxu1AQV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDyWvdxkTP6g4AXoP7MzK+nvhymYSIVmL4FzOdAG9YoSasi7zTqRue3Lis9z8sFdzA6iR0C415CGw0obUYdbh6gznqKk/fBvs6Y4rj0obxw5/wi6I7nwttdnGObUjyXH1/W8SNYBeBuTTETdhVNYuqyAstH44LiLUFKU2RtYBeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XLdGrKRd; arc=fail smtp.client-ip=52.103.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRt9L9YihM0HfLInNST4O1RlEzd+aQgJvwZFgsvcmVHOtCMqxsEkKkLwdrsfqzUnhnGImBjqOtnGTpOv4GJI2ou0UqJDnr0dOHMyjzpY3ayJ1rIYHTdRtcNT9t9eWo0ZY8N890ah6ebpV15EZoV+Tk3akfXp/Tn7TANxOWwAkVohtMDsTnQYw736rvb7PxbAacVJx/CWWwHlB3u7KUsxm4NxoqdEHrp7jhwp9msU6OyVkG/bc7Bn++oZL0Th4uwEqXUXPk/iSaZ4cOl5JOPlG80TLyzu1OkDTUy/Q6qKCcnGppUU6eLFhXKH6fh1d2Iz6vFsU4c13HFEGspN1D+sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrSYHzB4GW2sLJMaOp2oo3GKS0xvtKpmu2BHxu1AQV4=;
 b=DO8BttND1zJf1V2GBiuqRHjiSh5IkU4gcWQDNHtqydstzNBM5GBltzihvUhteKu1yTvuq037oTxwYAak6MXOIkorJ5FA9p+Dwq1VgtU0lix5Mms8gWX6QJ9+e+A9Y2ofSewVWKiC6lYS6MBQqnXv4lQhMySDXjEH75sAFKlmg8vj7UVd14TAr3mzX1u3T2ietuzKqDF+IzVWH0ZdkTUN3fqmXyikA5zbcNfTTZStCPZRFSWs5SBoK3jMJ9z34UHI+b++u8VrXP6fx9XWlD+YBFsGHuFmi1iLgZHLPGxynBDMVqb7TlfT3JjgUXSmEqN5NbXPxAjh1VKiR6bgm1zHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrSYHzB4GW2sLJMaOp2oo3GKS0xvtKpmu2BHxu1AQV4=;
 b=XLdGrKRdApBP56Sz0RZHjMwDP9fR6V9trWL6/SjJOAeIgB7y8GettzCeoFipXGe+9yCgej9LnGUaErKi76RrCR7eEwymfwW7CZBUhQaO7xC0lxFV+5sHda0FLnDomNtFwPEShTQk3j1eXLZAZiSk5ro+gXub09zL23D+qrgEIDNjCPZF8h8lFemtOeWdU90YYsIBkM9wn8vfYIOo+Av5Jwe4yo+35MBGBzn6WLl6SEZgknTjMdWwawMRaks9RO807IFduoT/vC+uruJriNeCBW9AUgZKKadm6fUywn9XtFXWWlypyVenPvhwVlSVyyRiZqEvetw/ZU+CzQd07upRDQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9820.namprd02.prod.outlook.com (2603:10b6:303:23c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 00:01:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 00:01:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH v4 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Thread-Topic: [PATCH v4 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Thread-Index: AQHcLwH6n8rMNUlRBEyCsepRDQ0gnbSqcQGwgAN3mQCAABfFsA==
Date: Thu, 2 Oct 2025 00:01:16 +0000
Message-ID:
 <SN6PR02MB4157331247B9CE7C99BB0C8BD4E7A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415781A21E3F8CF52AB2A579D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e12f4d2a-8e58-40fa-930d-5575cd097b04@linux.microsoft.com>
In-Reply-To: <e12f4d2a-8e58-40fa-930d-5575cd097b04@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9820:EE_
x-ms-office365-filtering-correlation-id: 5df7a650-f176-48f9-1cf5-08de0146cf0a
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15080799012|13091999003|8062599012|19110799012|8060799015|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z25nQjNFZjA5M28vNEl2akhlZ1VDYWJyL2VHakNsZXhNY2JQTGFxY2g4b2s0?=
 =?utf-8?B?TzgrYWZPa2lLd0EyWnRsY0NCWllqQk9QQmFPSEhmKzhmczZJR29sdUtPeFNE?=
 =?utf-8?B?QjBrS0ZSK2VEZUlCTEZWWGJ3c3FTU1BjRkdaK0s5d3NMa00xUHd0dUhRQkF2?=
 =?utf-8?B?ZFQwVkc2QnFSQkZsR1Y2QkpPWEFOeW1ZREE3cFhaTUlFVVZlUWptU2w4OERs?=
 =?utf-8?B?WURpa1htYUpPRmN3L0lya0t1UDRWQlhuTVpZZkNzYU04N1lTbzlpazBUVmZq?=
 =?utf-8?B?UnlYb1lGc21wQkNGMFAzenFxRm1nSTM1Q3E1a2N5RHJoaDhiV0tZM3JDN1Aw?=
 =?utf-8?B?enhIWlUrM1cvZWVSU3lsUVdYenZFbjhWUXlRVjdnSGxuSVVCOWR0MDVMZ3M4?=
 =?utf-8?B?S2xpekt1REJrSC9oZTZHa3BxQ0JZTjF1TjVsNnVabTE0aDdKdzRab0RaS084?=
 =?utf-8?B?b0xZa0U1TngvT0xKb2F5UDdrcUdIYzNVTjhCc1R2VzJwVSt6TFplU2lyTFV2?=
 =?utf-8?B?TlF1UlQ3OGZwTElTOFFnejlIN1RlOVM4QnVTSmRDdit3aXcreS9DZUZlaGs1?=
 =?utf-8?B?cHc5a0E4WjNrS1BTK1JIeFJSWHFMdk5yZ2RBZDlEanU3aGl0UW9FNmkxVklj?=
 =?utf-8?B?bk5wM2s3bFIwY3V6UXViVUpBK01sSVA0MU5BM0pwV1hqQmRjQzNjbFhpU0FI?=
 =?utf-8?B?Mi9Gb2F3ajgxNzROb1RGaWEvNVpOSU41aGQrQytjcW5TVEc3QklYRHBlOVFw?=
 =?utf-8?B?SHRLV3V0MnlZWEsycGo4ZTdIY1BvT1BBRGlpMi9QcmF6NTVEWjZuYVpiUFgv?=
 =?utf-8?B?aHJLWktGRThkMDhGV3dweGRIUmdQZ1BkTXYwNFJnM2pFU0M3aGcxbURNMFFC?=
 =?utf-8?B?Tks2Um1xMy9vbENxeGw0eFFYZzlGRGZZOEJwbUdtQlR2Qk5LZjZ4TVZubHpx?=
 =?utf-8?B?cm5hOENpdWhTNDAxTHd5Y1FFNHRFSWhGbEVqM1NEaWxmZGtNTGIrUTNVelBj?=
 =?utf-8?B?d25FS1RheEF3eVlPZllXZ1RFT0thMGdyYWZVbkFqaDZUckhrMmRnOWRnMkFW?=
 =?utf-8?B?QTRYc1lpRWJybUtqQ1FNcVNHZVU0V1Z2L0wzWVpDR09ZTzFZRVVKRlVTR3BF?=
 =?utf-8?B?MXYzWTJ6ek9jaXY2dWxMQndidWZCc09tNWp5V1FyZmVNRTRROGl2QTc3dWJv?=
 =?utf-8?B?bnVKOGh1TEx4ejZRbmNCRkg0NnlVenRoYVd2ZFV6S0NsZjFaTC9YblVHWEVJ?=
 =?utf-8?B?M0FYc3cxZVMzVmxQV2l1alpZWjJSVXd1dGMzNS9YWkhUWHNRYUpRUDR6ZDBN?=
 =?utf-8?B?aUYwNEx3K3paM2pRVFRaNUdGNFVQaGtDbHJ3MkZCb0JvbEovS3NxMkNnZkNH?=
 =?utf-8?B?SXVQMUFkS3RaK3Z6eEpiWktUNldOaFA5eWlmdEJabUg1czdHdFZyaXZ5SE56?=
 =?utf-8?B?eTU3UUlucytrb1kwU09wSXVWbjVYZHE3YWJjZERzK0M5T21nUHgvQWJUQWRx?=
 =?utf-8?B?RGdlc0JQYlNsZmowMzRoeFl4K21JbFczcFRGd2Fuc1ZwMHR3NmhWdXI5TVda?=
 =?utf-8?Q?WSiKFZDis/GrIwJZjOrZ/NH28=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUdIRnV3R3FjQ2ZMMlpkSEMwZzYyNnVhTmk5Tm4vR29MdVpnNkgyRmxkNG9D?=
 =?utf-8?B?UmZaZXNRRmNTU0h2VkxVblY1NUtGaWNPdmRBd3llRURDZjZPUCtpUWpOWWND?=
 =?utf-8?B?eE1RRVVRMHMrRDlLMlVuM2Y1dkpwTVc4bmxkRWI2a0diUVhpdE9jbko5d0dn?=
 =?utf-8?B?WGRaSmJaSG96b1VZK091VnBLOWxXRVRZaTNwNlJyY2RhMnJXMnByYS9yOGhO?=
 =?utf-8?B?WStaY3RIYjBFZ0tmMkJuREhQK0dVampKT2RlZ1hUVE1QaWFya1hHM0dqMkhp?=
 =?utf-8?B?NndCQ0hXTFZzUUEybFFOTkVSNW9QMkpIZlRFTU5jc1FkdlMxQ1NJcUxDTUlv?=
 =?utf-8?B?NDVIWk16eDc5cms4dWJ6ZVhkSldSTEZCbVIydTdlMkltYVg5MDBSQ2IxWHRQ?=
 =?utf-8?B?TzNJUXJyR2RyYlAySWV1U2JqektIM3hyaWxQY3d4dWljd1lOLzNqSXBrYi9U?=
 =?utf-8?B?aVcwTEZWQThlRld6MFVEZEZxZEFtWmlncndnTHZFK1IrMUpia3ZKTzd6SlBH?=
 =?utf-8?B?cHZ0aFhSczVaM2pwMlZhanRhYTdmNVkvSVpvMkQ4NGVRNi93cFB1WlNBNzkx?=
 =?utf-8?B?UHRTakgwUEF5WVh2TzVGdTEvNE5NM3RLNWs3dzQ2LytwMEExREhOZkMrZ256?=
 =?utf-8?B?RThLaTJNWXg0ZUgxcmpjc1p0UXNTT3hENGpGMWlPK3JEaEtYWjB1TGNjcitu?=
 =?utf-8?B?TG1WdnRCWm9JcVZmdHZGSUladFZ3MDRCRldjSzh5QStwek1vM1BDSUZNZGF6?=
 =?utf-8?B?bkhWb2liUnFPeTFFdWNzYkkwczhoSFpQWnhaR2Z5NWpyaWMyaXAycU1DWEZl?=
 =?utf-8?B?ZVF3cytZUEJ4bGVUb1NTYWY5SksyQXZObGVIcFVLZ3NoVXBaemVBZ20yekl5?=
 =?utf-8?B?dkVXc3NyM2VQVTlFQWQ2SVhwbE8ra2JmTTFLdmFpYTJyMHg1VS9Hd1JZcEZa?=
 =?utf-8?B?N1l6VXVxOUt0KytnSnUwYUQxRUpRNG83YVFYekhVY21na3JETHZNc2lDS21v?=
 =?utf-8?B?QWNsbDBDak1UbWM4SW9TOWR0cHg3bmVQWVh2WjRFYzVvNHFBMDR6aHFIQVpw?=
 =?utf-8?B?enNyVG9pdnNJbDZuSG1jcEtOR0VNWGxzaFNETlF1OGJzTUFkYUdObnIwSVI0?=
 =?utf-8?B?aVZ1RFhRVEUwMXVCTUpra29yQllkRUFVSVF0blNLcDlXTU0zK1pHM3VVRVl3?=
 =?utf-8?B?RmtROHRabmFpRFdtdngyT3ROWlFYcy92Y1k3cXYzUUZlc3NxK2JsRlFjcGVK?=
 =?utf-8?B?Qy8wcG9za1c2SDFqWVo5ZXFpbmJscU5rRkVQODlPQ0dBMG5pMGZTMGsrR3d2?=
 =?utf-8?B?WU1Qak12cG9NSGhTN2JvalVnTDZ0Z3lqeDhUMm05MGV5Q0dSMjF1QjhTUUlB?=
 =?utf-8?B?cXNGU0JwMnNpeHBtWkRVRTliRmpmR0NtVVBteHYxbldMeDhrQXJmZTlGVVBz?=
 =?utf-8?B?b1A0SHRFZ0JzSXJqVWVBMGN3Tjg4bFUwV0k0NmxFVHNDQXpxVndvKzVLSGpy?=
 =?utf-8?B?VjdoVENmVFgzZGtmclNWbWIwbmhydDRZek9KU3FQQnhRSExHYWpOR0NsbFV6?=
 =?utf-8?B?UnNEVEpPNWFMYUoxVGppWmhGenlpaisrY2Q1SVVZM21aV3M4T1YzaG5vUkk2?=
 =?utf-8?Q?fonLi4WiQRcMVrJaERiHyaLis71RsuFGplZg8OYH4laQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df7a650-f176-48f9-1cf5-08de0146cf0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 00:01:16.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9820

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMSwgMjAyNSAzOjMzIFBNDQo+IA0KPiBPbiA5LzI5LzIw
MjUgMTA6NTUgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE51bm8gRGFzIE5l
dmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMjYsIDIwMjUgOToyMyBBTQ0KPiA+Pg0KPiA+PiBGcm9tOiBQdXJuYSBQYXZhbiBDaGFu
ZHJhIEFla2thbGFkZXZpIDxwYWVra2FsYWRldmlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPj4N
Cg0KW3NuaXBdDQoNCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHlwZXJ2L2h2aGRrLmggYi9p
bmNsdWRlL2h5cGVydi9odmhkay5oDQo+ID4+IGluZGV4IGI0MDY3YWRhMDJjZi4uNDE2YzBkNDVi
NzkzIDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2h5cGVydi9odmhkay5oDQo+ID4+ICsrKyBi
L2luY2x1ZGUvaHlwZXJ2L2h2aGRrLmgNCj4gPj4gQEAgLTM3Niw2ICszNzYsNDYgQEAgc3RydWN0
IGh2X2lucHV0X3NldF9wYXJ0aXRpb25fcHJvcGVydHkgew0KPiA+PiAgCXU2NCBwcm9wZXJ0eV92
YWx1ZTsNCj4gPj4gIH0gX19wYWNrZWQ7DQo+ID4+DQo+ID4+ICt1bmlvbiBodl9wYXJ0aXRpb25f
cHJvcGVydHlfYXJnIHsNCj4gPj4gKwl1NjQgYXNfdWludDY0Ow0KPiA+PiArCXN0cnVjdCB7DQo+
ID4+ICsJCXVuaW9uIHsNCj4gPj4gKwkJCXUzMiBhcmc7DQo+ID4+ICsJCQl1MzIgdnBfaW5kZXg7
DQo+ID4+ICsJCX07DQo+ID4+ICsJCXUxNiByZXNlcnZlZDA7DQo+ID4+ICsJCXU4IHJlc2VydmVk
MTsNCj4gPj4gKwkJdTggb2JqZWN0X3R5cGU7DQo+ID4+ICsJfSBfX3BhY2tlZDsNCj4gPj4gK307
DQo+ID4+ICsNCj4gPj4gK3N0cnVjdCBodl9pbnB1dF9nZXRfcGFydGl0aW9uX3Byb3BlcnR5X2V4
IHsNCj4gPj4gKwl1NjQgcGFydGl0aW9uX2lkOw0KPiA+PiArCXUzMiBwcm9wZXJ0eV9jb2RlOyAv
KiBlbnVtIGh2X3BhcnRpdGlvbl9wcm9wZXJ0eV9jb2RlICovDQo+ID4+ICsJdTMyIHBhZGRpbmc7
DQo+ID4+ICsJdW5pb24gew0KPiA+PiArCQl1bmlvbiBodl9wYXJ0aXRpb25fcHJvcGVydHlfYXJn
IGFyZ19kYXRhOw0KPiA+PiArCQl1NjQgYXJnOw0KPiA+DQo+ID4gVGhpcyB1bmlvbiwgYW5kIHRo
ZSAidTY0IGFyZyIgbWVtYmVyLCBzZWVtcyByZWR1bmRhbnQgc2luY2UNCj4gPiB1bmlvbiBodl9w
YXJ0aXRpb25fcHJvcGVydHlfYXJnIGFscmVhZHkgaGFzIGEgbWVtYmVyICJhc191aW50NjQiLg0K
PiA+DQo+ID4gTWF5YmUgdGhpcyBpcyBqdXN0IGJlaW5nIGNvcGllZCBmcm9tIHRoZSBXaW5kb3dz
IHZlcnNpb25zIG9mIHRoZXNlDQo+ID4gc3RydWN0dXJlcywgaW4gd2hpY2ggY2FzZSBJIHJlYWxp
emUgdGhlcmUgYXJlIGNvbnN0cmFpbnRzIG9uIHdoYXQgeW91DQo+ID4gd2FudCB0byBjaGFuZ2Ug
b3IgZml4LCBhbmQgeW91IGNhbiBpZ25vcmUgbXkgY29tbWVudC4NCj4gPg0KPiBZZWFoLCB0aGlz
IGlzIGp1c3QgZHVlIHRvIGl0IGNvbWluZyBmcm9tIHRoZSBXaW5kb3dzIGNvZGUuIEkgcHJlZmVy
IHRvDQo+IGtlZXAgaXQgYXMgY2xvc2UgYXMgcG9zc2libGUgdW5sZXNzIGl0IGlzIGFjdHVhbGx5
IGEgYnVnIChsaWtlIG1pc3NpbmcNCj4gcGFkZGluZyB3aGljaCBoYXMgaGFwcGVuZWQgYSBjb3Vw
bGUgb2YgdGltZXMpLg0KDQpNYWtlcyBzZW5zZS4NCg0KPiANCj4gPj4gKwl9Ow0KPiA+PiArfSBf
X3BhY2tlZDsNCj4gPj4gKw0KPiA+PiArLyoNCj4gPj4gKyAqIE5PVEU6IFNob3VsZCB1c2UgaHZf
aW5wdXRfc2V0X3BhcnRpdGlvbl9wcm9wZXJ0eV9leF9oZWFkZXIgdG8gY29tcHV0ZSB0aGlzDQo+
ID4+ICsgKiBzaXplLCBidXQgaHZfaW5wdXRfZ2V0X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCBpcyBp
ZGVudGljYWwgc28gaXQgc3VmZmljZXMNCj4gPj4gKyAqLw0KPiA+PiArI2RlZmluZSBIVl9QQVJU
SVRJT05fUFJPUEVSVFlfRVhfTUFYX1ZBUl9TSVpFIFwNCj4gPj4gKwkoSFZfSFlQX1BBR0VfU0la
RSAtIHNpemVvZihzdHJ1Y3QgaHZfaW5wdXRfZ2V0X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCkpDQo+
ID4+ICsNCj4gPj4gK3VuaW9uIGh2X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCB7DQo+ID4+ICsJdTgg
YnVmZmVyW0hWX1BBUlRJVElPTl9QUk9QRVJUWV9FWF9NQVhfVkFSX1NJWkVdOw0KPiA+DQo+ID4g
SXQncyB1bmNsZWFyIHdoYXQgdGhpcyAiYnVmZmVyIiBmaWVsZCBpcyB0cnlpbmcgdG8gZG8sIGFu
ZCBwYXJ0aWN1bGFybHkgaXRzIHNpemUuDQo+ID4gVGhlIGNvbW1lbnQgYWJvdmUgcmVmZXJlbmNl
cyBodl9pbnB1dF9zZXRfcGFydGl0aW9uX3Byb3BlcnR5X2V4X2hlYWRlciwNCj4gPiB3aGljaCBk
b2Vzbid0IGV4aXN0IGluIHRoZSBMaW51eCBjb2RlLiAgQW5kIHdoeSBpcyB0aGUgbWF4IHNpemUg
b2YgdGhlIG91dHB1dA0KPiA+IGJ1ZmZlciByZWR1Y2VkIGJ5IHRoZSBzaXplIG9mIHRoZSBoZWFk
ZXIgb2YgdGhlIGlucHV0IHRvICJzZXQgcGFydGl0aW9uIHByb3BlcnR5Ij8NCj4gPg0KPiBZZXMs
IGh2X2lucHV0X3NldF9wYXJ0aXRpb25fcHJvcGVydHlfZXhfaGVhZGVyIGRvZXNuJ3QgZXhpc3Qg
aGVyZSwgaXQncyBmcm9tIHRoZQ0KPiBXaW5kb3dzIGNvZGUgKGFsdGhvdWdoIGluIENBUHMpLiBJ
dCdzIGlkZW50aWNhbCB0byBodl9pbnB1dF9nZXRfcGFydGl0aW9uX3Byb3BlcnR5X2V4Lg0KPiBJ
IGRlY2lkZWQgdG8ganVzdCB1c2UgaHZfaW5wdXRfZ2V0X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCBp
bnN0ZWFkIG9mIGludHJvZHVjaW5nIHRoZQ0KPiB1bnVzZWQgaGVhZGVyIHN0cnVjdCwgZm9yIG5v
dy4NCj4gDQo+IEknbSBub3QgY2VydGFpbiB3aGF0IHRoZSBidWZmZXIgaXMgdXNlZCBmb3IsIGJ1
dCBJIHN1c3BlY3QgaXQncyBmb3IgZGF0YSB0aGF0IGRvZXNuJ3QNCj4gZml0IHdpdGggdGhlIG90
aGVyIHBhcnRpdGlvbiBwcm9wZXJ0eSBzdHJ1Y3RzLiBNYXliZSBzb21lIHJhdy91bnN0cnVjdHVy
ZWQgZGF0YS4NCj4gDQo+IGh2X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCBoYXMgdG8gYmUgdGhhdCBz
aXplIGJlY2F1c2UgaXQgaXMgYWxzbyB1c2VkIChub3QgeWV0LCBpbiBsaW51eCkNCj4gZm9yIHNl
dHRpbmcgcHJvcGVydGllcywgYW5kIHRoZSBzZXQgaHlwZXJjYWxsIGhhcyBhIGhlYWRlciBhcyBt
ZW50aW9uZWQgYWJvdmUsIHNvIHRoZQ0KPiBlbnRpcmUgc3RydWN0IG11c3RuJ3QgZXhjZWVkIGEg
cGFnZSBpbiBzaXplIC0gaS5lLjoNCj4gDQo+IHN0cnVjdCBodl9pbnB1dF9zZXRfcGFydGl0aW9u
X3Byb3BlcnR5X2V4IHsNCj4gCWh2X2lucHV0X3NldF9wYXJ0aXRpb25fcHJvcGVydHlfZXhfaGVh
ZGVyIGhlYWRlcjsNCj4gCWh2X3BhcnRpdGlvbl9wcm9wZXJ0eV9leCBwcm9wZXJ0eV92YWx1ZTsN
Cj4gfTsNCg0KT0ssIHRoYXQgbWFrZXMgc2Vuc2UuIFRoYW5rcy4NCg0KTWljaGFlbA0K

