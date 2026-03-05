Return-Path: <linux-hyperv+bounces-9153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPuTILXdqWm4GgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9153-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:47:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC10217BA6
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A69030917B9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EEC30FC1E;
	Thu,  5 Mar 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uBYvS4fN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027F2571DA;
	Thu,  5 Mar 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739855; cv=fail; b=JFk0FfJy1yhddhXUcGhBjsB4Icu0S8kB/6CfmRhV5ExawN/lny9UDxN37FBL5wgyyE6ESpwDQmUcctXVpqVIfEZx/fM74SKs/kajuYCIqPIYGnPDHCPwrd4bn0mrIXpqfdV2nMamTcVgWxKTirE5a7c27yHF7HpDQ6uBHb/8Fvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739855; c=relaxed/simple;
	bh=x02XObLSeZIaL/AmkYJr3DFopn2JTmkXnkg+FrNGILY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTAOBwOeN/SMTTkpeeTWdhaTn5rfpWMuLS7tzrVhzxFQSNFAzBfcXsa35JZdy5A5VJ/jcq6tVSUVoD+XOKrjObTlzUtGDbvjy/B/xGILiyG4Tf4HxAME2JD3w8upSOxmUwxK+O7xvzxqA/wh9Bdw9L+KzXEu1B+qtIUgyDUtlQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uBYvS4fN; arc=fail smtp.client-ip=52.103.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXN2E8/8LCPwT+JkhF+jZq/aVOyRQXpd/zuSsBP1dLgLVw6R4NN1r/Kw3RXzc3ERh71wIlW6hMS1ansBa/i06nkw7nQ4oEd95XaRsX12oi7vVpksNnUSS4mKtqsEr1+6prqetuehBGIKCAzlE1exNlxFkNBQoyPqPOUw1kTgRFFWRyES4WjBlo6vR+foFvglwwErhh3nNsQRdjIbIHVagQm0ueuxLoGQRRbSOzNjHgX1qIL1MTx2OHEzpmpfoZRE63kywmMoq08pRVhgpSw4fD7Ajcvqc/2OqgS72wJSSlt3E/TpVBvFNAPDG8E/g3bHV5HlDsk1giDPeO8mjUGnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x02XObLSeZIaL/AmkYJr3DFopn2JTmkXnkg+FrNGILY=;
 b=pJUIMS4YWffQT8eRHdVsS3sAmC6HMVgviCs9R0kVzhZytWkyKA/4ITQ6O4FqDEj5lyj9qQE6ICrQZuDTHxQDgf20PITizOWSw30kPRA3cuqH/lY9G14nNHLhlGF3nu7J9HQX6A5kSAYU7BzAojDIuBGllU8nagLldPYb59H2tIG2KEQqHKCczIFxwZ2menc1FvKQxDBVvnb6ustCd1s11KpL6tFOzHi8gLBukxrb5S90uBca2pxZUB5rgb735ELRkgFxlA6hyLbliumLw8TCOHUhWAVknW/ice3xNkgcFiU8qdkI2Lfca6WqILNoqE+2DdCW2nEs8oUgCanaNe8ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x02XObLSeZIaL/AmkYJr3DFopn2JTmkXnkg+FrNGILY=;
 b=uBYvS4fNDvsfDblAcrH91coops7dmicHagFEe1OJLmy+2cyZCTnTnHc4E3AfkFuGb6acpzP0S2knHwhn4RhNzD7xQx6XXCU5gnujqJv/u+ERk5zlOgNb+ykhpx56vbXbAx4DpCOtPTvemQ2FjGjAfeIlskARsoXVZgSDrMwePKnnkkJsduFF5YwGapJK+wpjbkbu8AvUs0PsS1DU13XyixLCAPkBKI3sH3D4IG1pEhu64Bo9Yr1pe/0CttNn3tJx4Yu80YTIoaM3LPeeyzeZpL7ov3ZBziaaAEgOciUa+EIgM7BB4I+G+vHp3Wgn7rgd0pBbA1hLMa/e16kybqDsYg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8726.namprd02.prod.outlook.com (2603:10b6:806:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 19:44:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:44:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] mshv: Fix pre-depositing of pages for virtual
 processor initialization
Thread-Topic: [PATCH 3/4] mshv: Fix pre-depositing of pages for virtual
 processor initialization
Thread-Index: AQGf/CXhq+vihj2DXZ0/OE6Cmc0kFAEfdfr3thCy/uA=
Date: Thu, 5 Mar 2026 19:44:12 +0000
Message-ID:
 <SN6PR02MB415714CDF0E1C42217B022BBD47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258382549.229866.5072213647599344057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177258382549.229866.5072213647599344057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8726:EE_
x-ms-office365-filtering-correlation-id: 5d23e6c0-3ee4-4909-6ccb-08de7aef9351
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|13091999003|12121999013|15080799012|8062599012|19110799012|37011999003|31061999003|8060799015|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEI5N29KeEhIZTRLMHBZcEUrTHVjSDZpcnkySXA2OFdEMUtKMDBVanJ6MTlF?=
 =?utf-8?B?OXBjK1o2M0FDWU1yRXlVMGV6T3dHU21XckNiS05UQzhIRmhTclM0ZWhNeG5k?=
 =?utf-8?B?S2hzTENCbXoxME9FN1hZbHZQVGdWZkZMT09odjQ0TmdQYlBtTTlOTzhjMEUy?=
 =?utf-8?B?UmNNYktSSXBDK3V2enllVXY3a0ZYNG1zeTNtMnBqZHJ2RWNGcmxhd1dtY1pN?=
 =?utf-8?B?VnJ5QVhWZUk4c1Bteko5d2o4ZXBjS1cwM0ZqMXNCS0dUT0JpZlhnSkxET3pT?=
 =?utf-8?B?b1R4NExidldsQXV0NkVXQTR0Ujlpd1ZSZ1M4NFZaek90SFZ6QmE0REhFRDNI?=
 =?utf-8?B?YS9EdS9JYjErV1p3M3hHZXgwM0pKZEpWKzBsUFh5UFdoTDBydExSVTdoYTNw?=
 =?utf-8?B?NU91TSswSW9vc2N5alNsS1lrNVN0NVdqQWF4c1F3MTAvc2VSdWNKOThQSHps?=
 =?utf-8?B?bHpFN3hFVlh6VHZhdnQ2YXY1cGQxWHY0QVdsZTZzOU85NERmL1lWcEMvVlRs?=
 =?utf-8?B?KzdNbGpuMXhnRlFCU2xFcm1XbXB4UjZZMXJ5RGRTU0UvV3RlRko5VXYzQnZD?=
 =?utf-8?B?a2dITlpqd0xscjRVTUZ2ZmVmOEFINm9rSkhMMmtIZUVhaVg4NUwxUmhrRmxn?=
 =?utf-8?B?Z3hCOXhZYXJjQ3FseldLZnZoemE3dXJ1TUJJU2d5UndPR0NWWkNFNmFUcCtU?=
 =?utf-8?B?VG44WURvWlcvVzdPUXlLMDJDVHNYMXNkR2FWOEQwOURRWnBYTVZXRWVCbnVC?=
 =?utf-8?B?QXMrWjJseTlaMmRiY1JubmZYaHFiV0V0MXVtUVBYV2dvM1dxeVF1TE1DUDU0?=
 =?utf-8?B?NGhERmlsOTJvblVvVGtPUnBRVUhZQ2ZlZGZMT21YU3NrQndGd1E5R0htOHpx?=
 =?utf-8?B?cHBYSTF3SGtvMGs2MUZBdFloQ0FLTXlnK2pkRzZrdU1sL3dUVkVEQmJxZm1R?=
 =?utf-8?B?bnl3OFBRMVVGRXBmRnVGMHljMmwwQnpJWHBYQnEvc2w3bTA4UTZPbW5SOEtF?=
 =?utf-8?B?bFpWTnlYMDJKcHNYY01LQW9FcDJlT1djUUdDekJjbTZGc2pTMlZHVmJvVFda?=
 =?utf-8?B?MWZpZXk5a1BEYkduaDlIMnpYUU9HYWJjczQ4QkpUZW1uT0p2NG5McmN5REcw?=
 =?utf-8?B?dk9oVyt5NUdDVm5MYVBPTWo1WW5jNTVyd2oyVWRvdFRvMUtYY1FxZ3VFcUwv?=
 =?utf-8?B?RVFuNGdyeHpCVEZmRFM0eDNQckJXZ1FGUWkwSmhxTTIrcnJ0eGhsVGNpSHgz?=
 =?utf-8?B?ZUFCZkNNd3JUaS90Z014MEVLQXQ5YU1Cd2J5eFVrY0xmcmRWajFPNlQwUUw5?=
 =?utf-8?B?cXBZR3VNZ1dvWng5OWpZWllYbGM1V1FJKzNNbFE5Q1dqeDBMMFZSS3M2UzZy?=
 =?utf-8?B?bUFlTmZGd2paOFNldHV4TnFiOFNqa1pjWG5IYmkyRzgvNUhWSnRvZkdYby9N?=
 =?utf-8?Q?UggZz2I3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVlYN1JqQVpOb0RxYU55WnZlQlcyRHlXaFZpQVVjNHVNMnNWcEozOXNwN3c3?=
 =?utf-8?B?TU9kb2tJakFpQWJLNjFrOGZDN0JzWkdubWc3enQ1YklGTDZvWGpPM3JxMHlt?=
 =?utf-8?B?dFRwekdVbXBpa08xc09LZUY2c05WL0F2eWMrSURLUkZ6Q1NVY2JBb3ZLYnFM?=
 =?utf-8?B?R1drMDZ5TlpWWTFQSUtZVHYvOWR0ZmVXZFR6Y1NsTmEwSXNzdlg2cWg4dW1r?=
 =?utf-8?B?YVBSZTUvekxzRk5TT0ZhT0puZ3hraGVjOUpBNUJoT0xBZDJpZHcrR1JmZW1r?=
 =?utf-8?B?Y2NGQzEyQ1dNSHhYanpzNW5sTFo4ZlZBOHVRQzdROHpsSlFac0x6QzVUU1g1?=
 =?utf-8?B?RHhtYkNjWkNsM2dxbUwraHhZU1A0Z0FteFc2MHdzQW5Db21jNFlPbVNQMHJF?=
 =?utf-8?B?SWE5NTl3SGNmQ3ZpVk9zd01nSDNxNnlQYnF4YlZSSDJMSTlEY2dkTGUvdS8r?=
 =?utf-8?B?QlVjUUwwd2FvSGcxNldQZzJzUUNPcDhrQ0hGdEFXMUVpNHYzRm1ydlFUWXQv?=
 =?utf-8?B?b1RteElwUDFDTGdybHF6dUhJUnJiY01pWWVwTFcxYzZaa2tyWUU4dE1IR3BK?=
 =?utf-8?B?cW5STUUwVUY3ZURoVXJyTGdFdHR4ZGh4RTlNODRkTS9pb1U3cGM3c2t1THJN?=
 =?utf-8?B?VTY2VWl6Z1lFYXNFdW5qbnNDV203Z0RDYUxHWWpuMkJzM2RicUl4M3R5cms1?=
 =?utf-8?B?dVZ4NnpFWXNqRHZaa1hUWUlLV0tQNTZBY29sMEVMejBrRVg0ODFpNTNLQUJp?=
 =?utf-8?B?a1Z0VHE5NDRxVHVwTDJEYUEvZnRlb2U0YmRjUFBkb1drbXFnTjVDTG5rbTVB?=
 =?utf-8?B?L09PR0ptU1IzTit4M0xHMUN1Qm9STytlOC91RkZpYkgrUlgyRUFueCt0TUZD?=
 =?utf-8?B?cnRwbXhUbVg1ZksweUpHVHhTSTVZRkVZaC9oQUcyZU1EWG92Z2Y3azdWeWxq?=
 =?utf-8?B?ZkRyV0dIbUY0dXlTeFVVTkV1U1M3SDROZXdBVUd5d2dkcndBenBwQ2lyaDBz?=
 =?utf-8?B?SVFaREVDZ09sSlNhQ1Qzc3Q3dGMxbnNBbFlGVXJSd3gzRTJpSSs0V2lSYkFn?=
 =?utf-8?B?cEVVMUhtYWxnOHVMUmVwVHJVcHV2NzZEVzM1ZW0zWWtIZXJuUXNmd0lEV20z?=
 =?utf-8?B?UUUrY0hzdmdQU0FvVFR3T0U0aGN3ZlVqaHBuRWNpSjUvc0FEZUxnVGI5aFR1?=
 =?utf-8?B?cU1yQllHSkJJQkkwSXVzVHFnYldoQ0R5RENCUzlzNzhzZ2M4S0xJK2V0ZlZU?=
 =?utf-8?B?a0E4K0JKUUdWd21zMW1UcnNNN0NyQm1CV2V6bkZNYm9TNHFFQ2xrK1Jrdzhw?=
 =?utf-8?B?MzhHUlY3RE9EenNzblY2QXBXL2Y1UkxqSHFqTmprMUxVOEd1MnowK0MxMVBM?=
 =?utf-8?B?OTdYMGVwSWI4RDJBUWxTbGphMmN5T1dXNFozMGlGakZsaUNKQ0tVK0N5d0tm?=
 =?utf-8?B?OFBJQ0x2MTFjMXhSY2J6QmlXa25VZ1JjakExN3cyeGRmdzdCY2s0QWtacXRP?=
 =?utf-8?B?SEJVd3NxdVZuMnF6aGdHS3QxMmxhSW4wRTExN2ZGVWpmUUZZeC8wWkdIYlQ4?=
 =?utf-8?B?TmhMbVRJbzhmZWdaOUVIQS81Wnd2Nll5Wjl3cHB0TDZQR3lzUFFEVzl1WU0w?=
 =?utf-8?B?WkFHL1NuQmZ5UG8xa2QwWFFEZDhHbmJaVW1URFJlMU4rTE4vS3BYVTArTGRP?=
 =?utf-8?B?ZFdsTGVtRTFnVXlxampVSEdEZmxZd3hRbExmVDBMcjV1YmZnaHJ0bm5uV2hE?=
 =?utf-8?B?UG5OZDFacVdUQlBDampGR2I1TjBCeTVjRXZuWXFoNmJPd21rM2dsM0pHYVN4?=
 =?utf-8?Q?NI63eQD2Etj5BT3jadi8fhurZFDXXAoEdC/PU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d23e6c0-3ee4-4909-6ccb-08de7aef9351
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 19:44:12.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8726
X-Rspamd-Queue-Id: 8CC10217BA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9153-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTWFyY2ggMywgMjAyNiA0OjI0IFBNDQo+IA0KPiBEZXBvc2l0
IGVub3VnaCBwYWdlcyB1cCBmcm9udCB0byBhdm9pZCB2aXJ0dWFsIHByb2Nlc3NvciBjcmVhdGlv
biBmYWlsdXJlcw0KPiBkdWUgdG8gbG93IG1lbW9yeS4gVGhpcyBhbHNvIHNwZWVkcyB1cCBndWVz
dCBjcmVhdGlvbi4gQSBWUCB1c2VzIDI1JSBtb3JlDQo+IHBhZ2VzIGluIGEgcGFydGl0aW9uIHdp
dGggbmVzdGVkIHZpcnR1YWxpemF0aW9uIGVuYWJsZWQsIGJ1dCB0aGUgZXhhY3QNCj4gbnVtYmVy
IGRvZXNuJ3QgdmFyeSBtdWNoLCBzbyBkZXBvc2l0IGEgZml4ZWQgbnVtYmVyIG9mIHBhZ2VzIHBl
ciBWUCB0aGF0DQo+IHdvcmtzIGZvciBuZXN0ZWQgdmlydHVhbGl6YXRpb24uDQo+IA0KPiBNb3Zl
IHBhZ2UgZGVwb3NpdGluZyBmcm9tIHRoZSBoeXBlcmNhbGwgd3JhcHBlciB0byB0aGUgdmlydHVh
bCBwcm9jZXNzb3INCj4gY3JlYXRpb24gY29kZS4gVGhlIHJlcXVpcmVkIG51bWJlciBvZiBwYWdl
cyBpcyBiYXNlZCBvbiBlbXBpcmljYWwgZGF0YS4NCj4gVGhpcyBsb2dpYyBmaXRzIGJldHRlciBp
biB0aGUgdmlydHVhbCBwcm9jZXNzb3IgY3JlYXRpb24gY29kZSB0aGFuIGluIHRoZQ0KPiBoeXBl
cmNhbGwgd3JhcHBlci4NCj4gDQo+IEFsc28gd2l0aGRyYXcgdGhlIGRlcG9zaXRlZCBtZW1vcnkg
aWYgdmlydHVhbCBwcm9jZXNzb3IgY3JlYXRpb24gZmFpbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaHYvaHZfcHJvYy5jICAgICAgICB8ICAgIDggLS0tLS0tLS0N
Cj4gIGRyaXZlcnMvaHYvbXNodl9yb290X21haW4uYyB8ICAgMTEgKysrKysrKysrKy0NCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X3Byb2MuYyBiL2RyaXZlcnMvaHYvaHZfcHJvYy5jDQo+
IGluZGV4IDBmODRhNzBkZWYzMC4uM2Q0MWY1MmVmZDlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2h2L2h2X3Byb2MuYw0KPiArKysgYi9kcml2ZXJzL2h2L2h2X3Byb2MuYw0KPiBAQCAtMjUxLDE0
ICsyNTEsNiBAQCBpbnQgaHZfY2FsbF9jcmVhdGVfdnAoaW50IG5vZGUsIHU2NCBwYXJ0aXRpb25f
aWQsIHUzMg0KPiB2cF9pbmRleCwgdTMyIGZsYWdzKQ0KPiAgCXVuc2lnbmVkIGxvbmcgaXJxX2Zs
YWdzOw0KPiAgCWludCByZXQgPSAwOw0KPiANCj4gLQkvKiBSb290IFZQcyBkb24ndCBzZWVtIHRv
IG5lZWQgcGFnZXMgZGVwb3NpdGVkICovDQo+IC0JaWYgKHBhcnRpdGlvbl9pZCAhPSBodl9jdXJy
ZW50X3BhcnRpdGlvbl9pZCkgew0KPiAtCQkvKiBUaGUgdmFsdWUgOTAgaXMgZW1waXJpY2FsbHkg
ZGV0ZXJtaW5lZC4gSXQgbWF5IGNoYW5nZS4gKi8NCj4gLQkJcmV0ID0gaHZfY2FsbF9kZXBvc2l0
X3BhZ2VzKG5vZGUsIHBhcnRpdGlvbl9pZCwgOTApOw0KPiAtCQlpZiAocmV0KQ0KPiAtCQkJcmV0
dXJuIHJldDsNCj4gLQl9DQo+IC0NCj4gIAlkbyB7DQo+ICAJCWxvY2FsX2lycV9zYXZlKGlycV9m
bGFncyk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5jIGIv
ZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5jDQo+IGluZGV4IGZiZmM1MGRlMzMyYy4uNDhjODQy
YjY5MzhkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMNCj4gKysr
IGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5jDQo+IEBAIC0zOCw2ICszOCw3IEBADQo+ICAv
KiBUaGUgZGVwb3NpdCB2YWx1ZXMgYmVsb3cgYXJlIGVtcGlyaWNhbCBhbmQgbWF5IG5lZWQgdG8g
YmUgYWRqdXN0ZWQuICovDQo+ICAjZGVmaW5lIE1TSFZfUEFSVElUSU9OX0RFUE9TSVRfUEFHRVMJ
CShTWl81MTJLID4+IFBBR0VfU0hJRlQpDQo+ICAjZGVmaW5lIE1TSFZfUEFSVElUSU9OX0RFUE9T
SVRfUEFHRVNfTkVTVEVECSgyMCAqIFNaXzFNID4+IFBBR0VfU0hJRlQpDQo+ICsjZGVmaW5lIE1T
SFZfVlBfREVQT1NJVF9QQUdFUwkJCSgxICogU1pfMU0gPj4gUEFHRV9TSElGVCkNCj4gDQo+ICBN
T0RVTEVfQVVUSE9SKCJNaWNyb3NvZnQiKTsNCj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4g
QEAgLTEwNzcsMTAgKzEwNzgsMTUgQEAgbXNodl9wYXJ0aXRpb25faW9jdGxfY3JlYXRlX3ZwKHN0
cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFydGl0aW9uLA0KPiAgCWlmIChwYXJ0aXRpb24tPnB0X3Zw
X2FycmF5W2FyZ3MudnBfaW5kZXhdKQ0KPiAgCQlyZXR1cm4gLUVFWElTVDsNCj4gDQo+ICsJcmV0
ID0gaHZfY2FsbF9kZXBvc2l0X3BhZ2VzKE5VTUFfTk9fTk9ERSwgcGFydGl0aW9uLT5wdF9pZCwN
Cj4gKwkJCQkgICAgTVNIVl9WUF9ERVBPU0lUX1BBR0VTKTsNCj4gKwlpZiAocmV0KQ0KPiArCQly
ZXR1cm4gcmV0Ow0KPiArDQo+ICAJcmV0ID0gaHZfY2FsbF9jcmVhdGVfdnAoTlVNQV9OT19OT0RF
LCBwYXJ0aXRpb24tPnB0X2lkLCBhcmdzLnZwX2luZGV4LA0KPiAgCQkJCTAgLyogT25seSB2YWxp
ZCBmb3Igcm9vdCBwYXJ0aXRpb24gVlBzICovKTsNCj4gIAlpZiAocmV0KQ0KPiAtCQlyZXR1cm4g
cmV0Ow0KPiArCQlnb3RvIHdpdGhkcmF3X21lbTsNCj4gDQo+ICAJcmV0ID0gaHZfbWFwX3ZwX3N0
YXRlX3BhZ2UocGFydGl0aW9uLT5wdF9pZCwgYXJncy52cF9pbmRleCwNCj4gIAkJCQkgICBIVl9W
UF9TVEFURV9QQUdFX0lOVEVSQ0VQVF9NRVNTQUdFLA0KPiBAQCAtMTE3Nyw2ICsxMTgzLDkgQEAg
bXNodl9wYXJ0aXRpb25faW9jdGxfY3JlYXRlX3ZwKHN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFy
dGl0aW9uLA0KPiAgCQkJICAgICAgIGludGVyY2VwdF9tc2dfcGFnZSwgaW5wdXRfdnRsX3plcm8p
Ow0KPiAgZGVzdHJveV92cDoNCj4gIAlodl9jYWxsX2RlbGV0ZV92cChwYXJ0aXRpb24tPnB0X2lk
LCBhcmdzLnZwX2luZGV4KTsNCj4gK3dpdGhkcmF3X21lbToNCj4gKwlodl9jYWxsX3dpdGhkcmF3
X21lbW9yeShNU0hWX1ZQX0RFUE9TSVRfUEFHRVMsIE5VTUFfTk9fTk9ERSwNCj4gKwkJCQlwYXJ0
aXRpb24tPnB0X2lkKTsNCg0KSWYgdGhlIHBhcnRpdGlvbiBpcyBhbiBMMVZIIHBhcnRpdGlvbiwg
aHZfY2FsbF9kZXBvc2l0X3BhZ2VzKCkgd2lsbCBoYXZlIGRlcG9zaXRlZA0KMiAqIE1TSFZfVlBf
REVQT1NJVF9QQUdFUywgYnV0IGhlcmUgaW4gdGhlIGZhaWx1cmUgY2FzZSB5b3UgYXJlIHdpdGhk
cmF3aW5nDQpvbmx5IE1TSFZfVlBfREVQT1NJVF9QQUdFUy4NCg0KPiAgb3V0Og0KPiAgCXRyYWNl
X21zaHZfY3JlYXRlX3ZwKHBhcnRpdGlvbi0+cHRfaWQsIGFyZ3MudnBfaW5kZXgsIHJldCk7DQo+
ICAJcmV0dXJuIHJldDsNCj4gDQo+IA0KDQo=

