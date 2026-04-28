Return-Path: <linux-hyperv+bounces-10410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIg4M1v972k5NAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10410-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 02:20:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13A47C1B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBCA9300609F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D642C1E9B35;
	Tue, 28 Apr 2026 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HzjM7eO4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013078.outbound.protection.outlook.com [52.103.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986B27707;
	Tue, 28 Apr 2026 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335638; cv=fail; b=S9ylt2Gy8sQ9ut0+DcanaL+G6OfvcI88zMUtSbfJBsXTy7KXJg+OCdXhl3OBXO4D1+9NvXrhQJuXXNbC6LS/GDK836uSf5mcadUCS0r61ff/ksch4HPJ2bCW8Fo/umcHXzaAUaeeEbb7GAge+/xA7+Q06kdmgv+T/BcVOhPB8us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335638; c=relaxed/simple;
	bh=OJew9q0WhV5CVPS04Og0ZZCjAp9mk+W0Sr9EKBQegRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N889QErwtgQ3LiSF/rv3WDuOD3Sgndy9dqf9ueCAUDeJvRQ9+Bxd7S/Y2xWzkmdo6+0yBz23nGW/mOUv+j3RBuSjcNIBwGpRysNQdFRnZIlescNE3JIY/dcNUtG9jLviD1EASgoH85fmP3NZJkr158rhrPpn6EGjHcPykLpGzSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HzjM7eO4; arc=fail smtp.client-ip=52.103.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp+uhZAD4EF6SFgEFqJ0XSc7OR11hhEUGN66hq2pRAVsyTB1OprUgL6to1llI8RMfeGgTnFioygU1V+5x/vacvm3ZxmjXsTDOzvu09Mcc2KA75P6/z/cvTyp6/pXh9Cexv7OKh0iT5AaRac7exSmlMByg6mGWSJKMJEeFTQZwpCt9WXjj+2ZOMcqvSK9iQghnS2tFWag5lTOwmLj5qxVgfGHv4tqpPK2QH5pDuTfjVql+FHUpQ9r9mbdUU2Uwbmyj8Pk2w5vy1FAPZ0ZKrufXM/LdZoYRibYXzr63yuSaKAjUA4ruxlMVqm+/sFT4fTrp35UJn3UzhQKNqJHxFeZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJew9q0WhV5CVPS04Og0ZZCjAp9mk+W0Sr9EKBQegRg=;
 b=TRbeObwWUkzY1NJbQXupVoTu5uc/W1+lbk8EDRwq+MIDerawjZ83Wc1+PUt/rlFGphfAJSexw5R4pppHDOYrnMIIjGArpSUg6DWbBLfUFi1c5D0cd2DONjbxbrYj1nXYJ+v72rht9EtOfSNG8HcouNNZx/g/Hqy0Otv7rK/4IqxQyKIJ2y6VFWRopGBLtQW4NQKMOtWyMTXKhB9MyZFojsjsV0QfQBwaH0/kqcnOZK5+bnvUCDxInHWA3p4NP9rmEJ/mHgCF/Jj8bRiwT/8PKMviOCTfpWLqRMBLQDv8HNaMR31e55LALtG3+3PgHqAyLvbKLDJ3sZnTQMDXHFPZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJew9q0WhV5CVPS04Og0ZZCjAp9mk+W0Sr9EKBQegRg=;
 b=HzjM7eO4voJ7G8iYPvheggdcNZSvKBKci553U3fZuoubF7F8H4MsREu+JAJbS6wgTZMNsSoyNLyEmWAqcjnzwz4pZgby+eYk20HsH++mVhNox8e2q4rEmaRNw+UWyDoD0CnFmc5a15wWj4T8ruUe8WzIisRxQeC9yIpiNL+Vg3wckNESaa90kYg03P09IViAMeHamFOZL4gtz8u2wpo9X1MroREnty1Ky3Q65s//whE0qdUh6QtBgaJW1vBieoWflOolNwau/7kC4oVeXNXL4/Rm4RV4zrzLuZNgap10ZnGQWb3MvEw37X7ZRHtwMxeXlK6Q4K1e16pQBAQovXOKCA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8225.namprd02.prod.outlook.com (2603:10b6:610:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 00:20:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 00:20:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mshv: Fix interrupt state corruption in hv_do_map_pfns
 error path
Thread-Topic: [PATCH v2] mshv: Fix interrupt state corruption in
 hv_do_map_pfns error path
Thread-Index: AQHefAL+cMl0YDOcNjPDPHynPx4DkLXwTbbA
Date: Tue, 28 Apr 2026 00:20:35 +0000
Message-ID:
 <SN6PR02MB41578863BCE23D41B6A521B8D4372@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177730104962.21733.4130809041576931551.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177730104962.21733.4130809041576931551.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8225:EE_
x-ms-office365-filtering-correlation-id: 60f569e2-4ff2-42f8-25be-08dea4bbf79e
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|55001999006|31061999003|19101099003|51005399006|13091999003|2604032031799003|461199028|8062599012|8060799015|19110799012|15080799012|40105399003|440099028|3412199025|102099032|31101999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEQ5R3QwakI0aEV4ZkNKUmhhYmh1b0cyeUxDU0dEYlJIWnJraUVERlRpSkZ1?=
 =?utf-8?B?OWhHdjkvQzZZUU9OcW84SjlKTlRqUkFuTUlTTjE4SGQ3TjNHMXFyU3lpSzZH?=
 =?utf-8?B?N3FYbmNHQTRERkFvUXZqNml2RHhseitIUVdpbjJ5a3NtVGprL2NIWTlPMG5J?=
 =?utf-8?B?SVM5V253U0xwZmFxbkdUNmNuOHlkNWlvUFJmR2htZnJOZm5rN253SjQvdzBB?=
 =?utf-8?B?c21kdkFEYThoVXFOaEdJN2NXS3VJU0ZlK0JwaDdNS01PVjhTWG95Y1hUai8v?=
 =?utf-8?B?K3ZlRWd6bm4rZzJoTFRMdHhQQWtJaTBOQlJGcTl6VC9ITEhOemhxeXRYSDVy?=
 =?utf-8?B?ZlRTd3ZPSk5MYm1OaWgweDdNUzdwVmpEeDJXZWdQUDRHM3JWOENTOEhSdE9R?=
 =?utf-8?B?Mm9UTUJJRGhlZjVaTnlYU1VIeEtCSlNJU29zcGhsZTRpbFNRcXJxMFgvenph?=
 =?utf-8?B?NUZnbkFWSVhST0VnMUdPYnJ4MDN4STlRTVJHbElWMEhDMHpSaTVMOCtHOWI1?=
 =?utf-8?B?Y2RLNURLdkh6QU0xb081WGlTYkRwVjZ0R1lVRXRHN1dsMUR2YThERU9QZlFR?=
 =?utf-8?B?L1Z5andYR2tWQ0J4MXp5N0IvTXpSRTVxYmxGOG1SQzVxVFRsK3FuRTJsV05x?=
 =?utf-8?B?SmZmbEVKVXc5S1B2aFBEZ2xyalhtd3lhQzdoK0RlUHppanhnS3h2TFRqa1Zu?=
 =?utf-8?B?bGQrbzZOOStQSVRjRDhISS8rRkt0bHpGYy9scmlpY0FHU3h6YjNPZHF3YWlQ?=
 =?utf-8?B?cGU1dGlWek81VFlpMGVjbXpuMTR0ajRtM1lKVFdhLy9HQVRpbVlwNlZwR0xB?=
 =?utf-8?B?YTU5TG90bEo0UHkwSkZyTzIvMEsvbmxQd1B0ektMSUcyam1iaUNqdHMyKzJS?=
 =?utf-8?B?dDNnN3FpR2ZZNWVQTHBtY0NaTldoMkhGVG93SW9NbTV4Q2RpK0dGZzgwa0dv?=
 =?utf-8?B?SzV2TU8zeFZqQ01RQlhLb3Bqa0lEczk2eTYwZWs2dTc1UElXZmsrY1ExUlkw?=
 =?utf-8?B?YUVtWFFweGdsa1hvdzFWcUdZTEt1bHkyRGlIMDhjVmhyM1VUa1lwNzJDdWhS?=
 =?utf-8?B?UDFHa2NBQW5qZ1ppTFp1SXB3Y0hiQUtaa1UzQXpCa25SRDdnbHVXZXNpQzhH?=
 =?utf-8?B?aHJqZFdNRDZYWTBTL0F5YTllVlp3UE5sWS8zU29va3ZvU29iSjVlS1JNcjhQ?=
 =?utf-8?B?T3NSS3FEZU9ZRysyUHJKaWVadytZK2p4bVE0dVdaTUpSMEpZdmM3aVZvZzB5?=
 =?utf-8?B?SnQ0b2lCV3JZemd5aXgrNGE1RlNpMlFwMmt1UDZ0Z3pvRFl4TFR4RDVIcHBr?=
 =?utf-8?B?UlhlNDh4cVB1c3gxRm83RzE2a3ByWDA4cDhEdk9FTnB4cUhwQkhxenlUbm5a?=
 =?utf-8?B?ZHpmTGRCVFpjTm1vK2Q1cUJnQmgvQmwwU3BaSk44ODRxVnIwTTNJOTdud1Bq?=
 =?utf-8?B?SXFBcGcvSFdEUjRXL0hJd3lIM2xPYUdERUdPTXZmLzBLWmtOdXVZa2F6Z0Rj?=
 =?utf-8?Q?PKNdus=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG9nMHBVSDhnWngyNmZVa3ZkT0xadE9neWZZOW1wZ3gyNmpsakV5MlJ4T01m?=
 =?utf-8?B?dk5vOWxrY2xFdWYxd0RJWlRSdG5JWlY0UThaZ2pkUG8wYkVwL2NicS9oWTNJ?=
 =?utf-8?B?TEhXak43NkJldFZxSE45RDlTbFN6ZCtIWDJPdWFRVC9IMkhoTFJ6K3N6VTgw?=
 =?utf-8?B?SkNIMDdRSHNhOWpVUjBkWXArMGZOVjZIUUhKVnRJY2tuQld3U0I3VGJ6RkdC?=
 =?utf-8?B?ZkMrVXJSSk01aVE5RnBwS1UvYmdXMUh2TGo1bFAvanBYRlRzOHVUbktneFA0?=
 =?utf-8?B?N3h1S0lPRE01cWQ5UE1reDlFenZFR1pvSWRHZEZzcjlqSldDVitHZG4zWXRm?=
 =?utf-8?B?SjFmdW92TDRRWTYyNjRwbzdaVW16dGQyWHVKYXR0TU5TTU9la1RPVlVXK0M1?=
 =?utf-8?B?d3NxZHdzZEkyMHZEbVlKVVRtZzFoWnVIZXkrUUJ2ZjNKd3BhWnQ2OTZFazJ5?=
 =?utf-8?B?UDNwVE9VbjlPZ1VxMFNqTTcxN0NBWXhCMVl2YjdBS0ZvV005RERDaVk3M2NC?=
 =?utf-8?B?dThGb2dBNHlLSW5SV1ZPQTFVcUhZTUN3WVNhRWxvR2pORHo5MXI5Nm9JVVJa?=
 =?utf-8?B?MjArOHFsbnlHdmhFRWhGcVRrbGMxMDNRRllmVHBaNkxEamZDeFRvTDBEN3Aw?=
 =?utf-8?B?ZExSaFhrK3d0Tk8vM1d4bHVXeEpJU25PYzF4VUNXREVETHplRVcwSzFPQ2RR?=
 =?utf-8?B?UlFhQUV6THBpMTROc1hKaWpqZXF4M3ZLWE1hUUJ2R1RzcVUrdmxQSE9aUEx6?=
 =?utf-8?B?VzQrNGhOK2thMVVDZUo5anViL3RLYnVIT0svWDVnR0tPNC90VmwrR3lGNGRY?=
 =?utf-8?B?eFRraTBvU1BGV1FiTkd2VVM1WE4vVW43TE9vbFdDTTBsbkdteWxwMkJGZTdu?=
 =?utf-8?B?RWxjZEphRWJ1d3diWURqT1VoZnpDUXNrSDUrMDBjWGtaV0Z0ZUtnbzN6Q2ZO?=
 =?utf-8?B?UWtvNDRpc1A4b2Y3SE1uZ2wvbFFId1pVTThxRDN5ZXd1bTY0R20rWDh5Y1VJ?=
 =?utf-8?B?L1Q4MXZpVU9iMEpMOHlUQU0zcjQ0TEhac1ZYZmxuQ1FNRldpdHZiTEk1dkpo?=
 =?utf-8?B?cFdZdVdQVXd3R3l2VnhaTlk5R1JnN0NVT2QwdDJBTHNjTTc0WXM3OTB4aG1Z?=
 =?utf-8?B?aUY3dDN0U2tueTZtRjZoMTlic0tKbEJEeld3b3BWeGVic0hLQkN2Q3kzVFB4?=
 =?utf-8?B?VzExSDRaRlVMYTI3TXhHcVVvNHozQUcrSVlhK1l2SkxUV05MOXlGU1k5QzRp?=
 =?utf-8?B?YlBJTDEvUThEZDlEcm5WUnU0TFY4aGpnQ2t3QXdHOGZPb2ZOcDZUdEFxYlpK?=
 =?utf-8?B?WHppTEY5Q20xaGg1Z2dwMGFqcEhadnVrY294K3hqVml0Z29LMmQxRGVwTGdB?=
 =?utf-8?B?Q295Z2h3L09Hc24yb244elZTUGhERXJBUk5UaDlROWtMZmpRSUFVOU90cVpE?=
 =?utf-8?B?QUFnbjlSa0ZhVGcybmJtYS9Ga21TblIyN1ptUmR1QlB2by93L3BzUnJxQkpM?=
 =?utf-8?B?eWEzMjV5M2pRV3NpWG5oS1JidnNDQmphYUw3Vm5CK3duejZFckViZ3MyVjdu?=
 =?utf-8?B?Q0swNHR4ZmJOSkRpbVNFVTZ5LzkwcWF4LzFTbEQ5MFNWaXdZbHkvL0poRnBn?=
 =?utf-8?B?OFo3Y0JDNlRQSEU2TFAwZStncGYxSnVyVk1LQlZyL1VuUFVWQytqSXhSRDg4?=
 =?utf-8?B?ZFgrc0tQL25DUG01K09aSnVaSW5IUnFHZ3dDa0FHVDl3RTZnRmlldTZVYmdX?=
 =?utf-8?B?RHcyKzN0WmxLN1MzN1dodCtVWEg3cGpENXBsRUk5Nnh2eTZRN0pleDBPU3lY?=
 =?utf-8?Q?2Jr0gdMmBieYfYaKLy19tKhh+jWjkfV7vur5o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f569e2-4ff2-42f8-25be-08dea4bbf79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 00:20:35.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8225
X-Rspamd-Queue-Id: CA13A47C1B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10410-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim]

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogTW9uZGF5LCBBcHJpbCAyNywgMjAyNiA3OjQ0IEFNDQo+IA0KPiBSZXN0b3Jl
IGludGVycnVwdCBzdGF0ZSBiZWZvcmUgYnJlYWtpbmcgb3V0IG9mIHRoZSBsb29wIG9uIGVycm9y
Lg0KPiANCj4gVGhlIGlycV9mbGFncyBhcmUgc2F2ZWQgYmVmb3JlIGVudGVyaW5nIHRoZSBsb29w
LCBidXQgdGhlIGVhcmx5IGV4aXQNCj4gcGF0aCBvbiBlcnJvciBmYWlscyB0byByZXN0b3JlIHRo
ZW0uIFRoaXMgbGVhdmVzIGludGVycnVwdHMgaW4gYW4NCj4gaW5jb25zaXN0ZW50IHN0YXRlIGFu
ZCBjYW4gbGVhZCB0byBsb2NrZGVwIHdhcm5pbmdzIG9yIG90aGVyDQo+IGludGVycnVwdC1yZWxh
dGVkIGlzc3Vlcy4NCj4gDQo+IEZpeGVzOiA2MjExOTFkNzA5YjE0ICgiRHJpdmVyczogaHY6IElu
dHJvZHVjZSBtc2h2X3Jvb3QgbW9kdWxlIHRvIGV4cG9zZSAvZGV2L21zaHYgdG8gVk1NcyIpDQo+
IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4
Lm1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5j
IHwgICAgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5j
IGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+IGluZGV4IGFiMjEwYTdmY2I4YzMu
LjYxMjkxZWM2ZjM0NjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2Nh
bGwuYw0KPiArKysgYi9kcml2ZXJzL2h2L21zaHZfcm9vdF9odl9jYWxsLmMNCj4gQEAgLTIyOSw4
ICsyMjksMTAgQEAgc3RhdGljIGludCBodl9kb19tYXBfZ3BhX2hjYWxsKHU2NCBwYXJ0aXRpb25f
aWQsIHU2NCBnZm4sIHU2NCBwYWdlX3N0cnVjdF9jb3VudCwNCj4gIAkJCX0gZWxzZSB7DQo+ICAJ
CQkJcGZubGlzdFtpXSA9IG1taW9fc3BhICsgZG9uZSArIGk7DQo+ICAJCQl9DQo+IC0JCWlmIChy
ZXQpDQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJCWxvY2FsX2lycV9yZXN0b3JlKGlycV9mbGFncyk7
DQo+ICAJCQlicmVhazsNCj4gKwkJfQ0KPiANCg0KVGhpcyBsb29rcyBnb29kIGZvciBmaXhpbmcg
dGhlIGltbWVkaWF0ZSBidWcuDQoNCkJ1dCBJJ2Qgbm90ZSB0aGF0IHRoaXMgZXJyb3IgcGF0aCBv
Y2N1cnMgc29sZWx5IGJhc2VkIG9uIHRoZQ0KaWYgKGluZGV4ID49IHBhZ2Vfc3RydWN0X2NvdW50
KSB0ZXN0IGluIHRoZSBwcmVjZWRpbmcgJ2ZvcicgbG9vcC4gVGhhdCB0ZXN0IGlzIGENCiJjYW4n
dCBoYXBwZW4iIHNhbml0eSB0ZXN0IHRoYXQgbmV2ZXIgdHJpZ2dlcnMgaWYgaHZfZG9fbWFwX2dw
YV9oY2FsbCgpDQppcyBjb2RlZCBjb3JyZWN0bHkuIEF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1
bmN0aW9uIHRoZXJlIGFyZSB2YWxpZGF0aW9ucyBvZg0KdGhlIGlucHV0IGFyZ3VtZW50cywgd2hp
Y2ggaXMgcmVhc29uYWJsZS4gQnV0IHRoaXMgc2FuaXR5IHRlc3QgaXNuJ3QgYmFzZWQNCm9uIHRo
ZSBpbnB1dCBhcmd1bWVudHMsIGFuZCBpdCBhZGRzIG5vbi10cml2aWFsIGNvbXBsZXhpdHkgdG8g
dGhlIGNvZGUNCmJlY2F1c2Ugb2YgdGhlIG5lc3RlZCBsb29wcyBhbmQgdGhlIG5lZWQgdG8gZmln
dXJlIG91dCB3aGVyZSB0aGUgdHdvDQoiYnJlYWsiIHN0YXRlbWVudHMgZ28uIEknZCBhcmd1ZSBm
b3IgZHJvcHBpbmcgdGhlIHNhbml0eSB0ZXN0IGVudGlyZWx5LA0KYWxvbmcgd2l0aCB0aGlzIHRl
c3Qgb2YgJ3JldCcgYW5kIHRoZSBuZWVkIHRvIHJlc3RvcmUgdGhlIGludGVycnVwdCBzdGF0ZS4N
Cg0KTWljaGFlbA0K

