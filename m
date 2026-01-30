Return-Path: <linux-hyperv+bounces-8593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNosB1gIfGnqKAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8593-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 02:24:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEDB6245
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 02:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB6B300D32F
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6B30F7E2;
	Fri, 30 Jan 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qP2CHqfb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010023.outbound.protection.outlook.com [52.103.2.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEE22B8AB;
	Fri, 30 Jan 2026 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736277; cv=fail; b=AQljrmGAoONuyi9vjFWf/LGR6e3m1MKnTBkTTs9Ny5a3rvKDzfRZrByk2pOvdQjNXFm1z042R+NJk6jVYmvOmfa2c8//r6QDLpg3zbF2/haLpOJPKBJexvhBIRAvyF0ltTHX8V6lnqFWHyOQinR5a0fg1h2mK7+YXZvceWk3MlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736277; c=relaxed/simple;
	bh=VDHmPcEspvcmnr89lyawVK/8OEb/K1R/TlSZbrIS2tA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujbZpuldLuiNnoZFQ/RFytYNad5Uuz9rpiDFcjoKkVe3ckB9HUKaiS+kJ6WdHjp2HHtPdm5jo/vJELR1O0jupoLXNzjO5navPN690Z8yWLJ57D9CIrtN4lh6OfGj4Sa+YOUJa9FJ1Z+mlDW6jAvQYd+U6GaQmodV+JaVDUIeVv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qP2CHqfb; arc=fail smtp.client-ip=52.103.2.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSSOcvdewZ5q+cOfeukhFtvyxYYwxnK5WivkHXRPTa5UjSkoxWKY61hYThLhW0Dw/9wT07uICc6jCAr5iREE1XgwUXZJDca1xVgozk1DIraP95R1bkxK9gs0V3hOZtRS/Uu1uSRlYfr7QgtINqCccU3RNo0vuyYoV7NAK6zRIqfH+mg2dIkWKwxSYna/hE4Bq9+uHgmN0+kr3GvEjuoqN0IHFR/UMo1q2slU9EF4MWNndtiL6zkXszNJz31xY1iiCOc+QRuG+F0o5Z3rH+UpncorGLDidIqOX9WvzylR8s9/h3aGX1VnaI3XK1qeVg75RwPTEcpIjcvi5BmrQFnU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJnkbWFKw84OE9pEmViPaL0My/6ljvLbqrz8b1knkIw=;
 b=BZkKFqFNMVwpwjBG+WowVJOVY72rCjD0DhxhRyjQhtmpJKDUzBaP3Ej28y4AgIDAwtC1JqaUAhpoIFSdDM8////l+dCac74pIixPSkz20CfqjG0xgFWxKhP/pk0ZG3jnpsNERu0wVL0fpZnfGyYdfaX/ddu10dzNFdyQOSir+vP+3xT/m3ZKIB1x5FH+1LOBjPnoQUxSm7VgdKVIHhaDFgQxD8s5rC2i1hZH3v4y91wsfapFo+GtsiFbRbEQpN9tozGp0SSyT2Tpw2PY7/NtX+U8TxHesXh0u/u7KOwnFsFVn6yknIlmhNa5HVRl8jjDsjAIZJlbZ+HjA/SuKom1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJnkbWFKw84OE9pEmViPaL0My/6ljvLbqrz8b1knkIw=;
 b=qP2CHqfbrZTIOSm+xBj9kvPJdIJ8qSbn8YDiwC2U1vsNy9FRRa1nmlwlXZWl1JiLECvUeaJLrcQ7sqCuMnGQjpn6vO5VanC9rn44fk30cqL63vERjvrDs1JQTqkjkL1z+YyAqO1bFl9Cs7YpNkJtmBQ4g5WjUrLKw1vzO4fNVEuQdJneYwkp2mRznOorCSrXpsqA31zhJzH2jxYJZBlBr3Gd6nZeKbI2Vx8PEJxRci2EeWpoPmq0ABPtrasGSH0DmEjMjmVTN5KKM5SAxx78X9ql3J9YljgzFrZA44D2ps3xXQKjMqbG8Qx6/mP33E2C3EGeGYjHVWSMdA74oC6MbQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 01:24:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 01:24:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mshv: Add support for integrated scheduler
Thread-Topic: [PATCH 2/2] mshv: Add support for integrated scheduler
Thread-Index: AQHci72MSasuUoF5ME+DlBsQrQadr7VpZ+CwgAAmTgCAAGPYQA==
Date: Fri, 30 Jan 2026 01:24:34 +0000
Message-ID:
 <SN6PR02MB4157EE41697ABC1002750297D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
In-Reply-To: <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7065:EE_
x-ms-office365-filtering-correlation-id: af5e81cb-e20c-4f9c-ebcc-08de5f9e5397
x-ms-exchange-slblob-mailprops:
 igNrEvV8uhEvpyeJ/Jdph30uiRXy5wZPWOCR3hobzXJVcqluARRRFd0iZ9X24TUCAwqvEdClMTaa9y0vryD+ySZQmIKETj8ppwjh55yMEYeWznLWq89OP7Odkh+62LPfjZ83DWKzyo694GFF9X4rPCCwGOEBYj4ekxcD4c6gT6ZbbRcdmWhIiyRIMgscNfIAN1E/6YWW3q34MxFVKctL6mqQV9PvQKGxuyKygC0iIfY0PTSEZ6SDlaTofTkPgL6K+575CFGpdw0imknxM72yJjPvYfS//tiC9mca7APyOcvExZU+6p7/3qYp2uFQM92Od1yQ7k6uFzRznacSG4yhFH95coP8zt4XZk2Gb9xbfTUf30N6oxsjI6mO1hnIKZrmNmUPtT/x4AI0eJPxqE0Ja2LLF2GCbDSj5I/Vw3TVktWleKWBmD1GkdAGwbb4ax0jtMctEN5mFoQPTDqsGvvk9BbrJxlYT1TAkuXcc8DXQZepA5PrPD/TPlrYblJPJE1G+E1Gua1SvkKwdEzth+gws/dtmUcJ/0PjIUphZeDuhfhQr8SmPwyDH6GOB3/oawDZjvRNRfOVyeegVUpLXTOE7bOXnwd02pVAQCHPDv8eIQpo/J9GzyEitB1/9yAr2vTXyY5YD3zbe9y46UNjjB5prwe+g+RJZwF2BJacx6obN/D8AHVGP7I4vey17jhMhaMOHFDmoYLHMb4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|51005399006|13091999003|31061999003|19110799012|8062599012|8060799015|3412199025|440099028|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KDldBFnK0ZL64KmnV0LZyZwdwd4lqEaUs5UBYgn78V3Qg9SFYktiaDwVxigQ?=
 =?us-ascii?Q?UP+UJTaiyPgRRb2/D/dn9NNo7ZnkpgVwvRkV7vz4j69bKPD6Hi7StoJ/svmb?=
 =?us-ascii?Q?DSgNruBQeEWFUMFQZzKyYdw0/iuoBH18bqAUM5zOsR4y6lbv10LPLewlmdRn?=
 =?us-ascii?Q?7qaGFwBgun1fW27cT3iR6fEqat2fR0Wl8zaUDOV8MNegwVNroACoV2qjzPak?=
 =?us-ascii?Q?zMQmWqH4qyReDRvung2b9t5t8+uBHVUTYZIiVWB1aGOsLjJ/QSdCYMJxsFRR?=
 =?us-ascii?Q?E2r45wvGgstlP1d7J4k+4Qlu7a9PJr3u+Ce+HYe+I1wsttxypIJ7OXXVDf28?=
 =?us-ascii?Q?h175jKgcEz1A+TE8SAOgi2dwE4j8VAqF7q0NJDH0MmOnTHDxg6Ea61CDqdgv?=
 =?us-ascii?Q?KntijMdz8PneohGKrxTGrnGO6GgfY/SI6hAjXuOr675IdJF+3737RHgd+Dnd?=
 =?us-ascii?Q?PFzNxLM3tO47iq1oVfGdNj6N3FDoWpzJ3xZOyaExNx4vR4CkDQXuE1H3uBsy?=
 =?us-ascii?Q?o4KnckLd71Zpfau1Q994NsWGwrKcLSXGVnPU1W3/M+TrFxzjRr+02v+TRC2C?=
 =?us-ascii?Q?dEpvGzTyEiWmUDLJTJ59RJXiAEoNS2B89jLNYeAnYTt7TFj7qmjfPz4r2lzx?=
 =?us-ascii?Q?inxEhIvL7Wkjfxb3bje7ydbEtxgxRBWwUirNlfKhDwzo4H+y/J0fN6f/A0Fq?=
 =?us-ascii?Q?uJGkzKsounq91HdunPCI81XWirrjeLrYfY96LhIXpu4T0216CRcnWpIiepNm?=
 =?us-ascii?Q?6PMmd+gOjkERD+ZZ5nhSRBqPYQL9FLa443RlsMahCieiWG1osQDhTVXPHrem?=
 =?us-ascii?Q?+uGrOCEjqERp8dStip+zZQhaHJUASZSvh4SiaOuDF9FVrrXGHfF0gneMR/4w?=
 =?us-ascii?Q?tw9YwCMQzcYfzHYIACl2D4QlTEgSpNrHOHP1SSHPTZBYpmOWApc8xZzgqUYW?=
 =?us-ascii?Q?IStN2Ep0mGS1rUGkVG1dAx5VPLmgRM9B40DYHvY+aWQTcZLmi/ai4J6IUIUL?=
 =?us-ascii?Q?MDIM8Gimv1v64nH82hBEBoGn7QS2Hxn8/O/qUldyiWwDZ+yr8bjgCkev1e4j?=
 =?us-ascii?Q?iDsjdOnzlNcNn7RxclWnF6C51ZAoxSyhWGh6KGxeA4Itpji94mI1H8N8u4UO?=
 =?us-ascii?Q?5EEF6uoMR0UXVDIJCXmXutusrn47ySFm9pVM/jl/JZhVn1dj+QQerHnYVzuR?=
 =?us-ascii?Q?tcSXvw+cG6UPTk20fFClCcSN1mMgqcpbFEr4M5oQZbmDy+QoV9xqfNtqoxJx?=
 =?us-ascii?Q?ExuoYwMl73yUn7qe++926+HdD9BaYxIZneaU0rUqkQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kX3JQT06WUQpnO/hIrv6VX/jjPRsuGEc0vM9aoVAi93MoANQLkT1XsLfhuem?=
 =?us-ascii?Q?Bkej3oQj+mXWAYL9ei7i5pnx7gRDIHMQlSpC/LzV8Mcm2yLvRdOJZ3//8YPP?=
 =?us-ascii?Q?r3+2ZimkvMzxW4qYz0HDCXBOZddpBcEpENqaWzOUBRFyDrtRfMoLR2f7QMyl?=
 =?us-ascii?Q?rtK5RxS5AVCWOSNhlUS5y8dKOtNJgc4hakyK4AdOKwSNlCVQn9LxGj9ihhPA?=
 =?us-ascii?Q?GY2t/u2dsbzkSepeaLcJa9YnHoqeTaEeZTjQXythKBYmOqj/yYXMgw0jF4sL?=
 =?us-ascii?Q?lGRky0qT3Sk+Gk5hnvX8FFwwABDS4JVftnzKuhFPhqWgNQyfNp8lmByQS0R+?=
 =?us-ascii?Q?szGMSprBaOj2A1fhsglxo9r+8pBZwoeXnlLSbqTB9PthWqSWcARsGEF0iHYa?=
 =?us-ascii?Q?MpUw/D3FglkYInNJ99uk+j9eUJwXJRlOxa0WwCu8LwauQsKSrQtU+RTk4kGu?=
 =?us-ascii?Q?9oA5fAnpbiVEHthPyC3pqHRiaGo2HwISO7FG3aeQe8vwcJvDvQegFs/O89Ow?=
 =?us-ascii?Q?Tlj8IZ6pNSkLwg+7bjiXxR47NbpCtNRfAitVMY0HAN4lX6U9PN99lfDvgKRC?=
 =?us-ascii?Q?eIA+ClCTUuYLDwIQHpzC/ZfEZi3GqtG9DjMElJ4w5omjqTY0TpdZQMr8TzaK?=
 =?us-ascii?Q?vhHDxanCLTakb6zIEbuau048qDUNXU/XVGYZiPneSLNrvBOje7JRIlWjZvuv?=
 =?us-ascii?Q?6GEiNqR5lIeprnWvGPnhI2scsDdDVAX2EfufYT+wYxLbB98FP1/jueKJ1ylV?=
 =?us-ascii?Q?mEJuyN4hQq9CSh4ZdXSnnq1VOKux8GlXya6oPSJwsyfVqJZHLea3i7J46Yr5?=
 =?us-ascii?Q?ZXbpxJhqJRVT/xl1IuLRXFjZ8rUbo8+oFMFU9h6Ma2aYDfxw6fC3kdICJkMR?=
 =?us-ascii?Q?R9zNfA0GhZbiNafnQ3cinbSczavn9mXGEp5ywyOJaXajWrGWyXRoX62KXHy0?=
 =?us-ascii?Q?kEUI6iKSHxGFIDJOKNB5YVmOaQKXjvmQtgRuF9T9ypaesfVtds/f9eEltol8?=
 =?us-ascii?Q?BhbGhCLrV4GBgzR6+LLedLXdR9DA0a/Ix3Mf4qhEG+urZ006yQD0rSxtL7yQ?=
 =?us-ascii?Q?7989Xv+H8hlj7NSzGpVwhZBnLW6aVnXykOCc01ggmyEMBY2NAywjiJ3m8AwX?=
 =?us-ascii?Q?OXLD0ogDgcXv9hSq9z4qCWUi2nNUK1CJUFzycS1+B9zPvsmIdaC1FfNV3j3U?=
 =?us-ascii?Q?R09UuLH1Qio2DNRY7LD+11MpK2capjBgw/+5Vtr8m7VDoiGTmZYhbM8iRkpQ?=
 =?us-ascii?Q?EVQUB9/EaA2aB6IJrSevUKoHcBGD0E057mTdud7XqTd3t9Xl/t5yc+oPPIlx?=
 =?us-ascii?Q?jNpROHKs+ODQg0O45N3KVNpn6eRFnzS8kvAPlcA2v9XEokkaPczsZ1fkvuuX?=
 =?us-ascii?Q?Q3YqT0g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e81cb-e20c-4f9c-ebcc-08de5f9e5397
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 01:24:34.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8593-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 6ADEDB6245
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, January 29, 2026 11:10 AM
>=20
> On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: We=
dnesday, January 21, 2026 2:36 PM
>=20
> <snip>
>=20
> > >  static int __init mshv_root_partition_init(struct device *dev)
> > >  {
> > >  	int err;
> > >
> > > -	err =3D root_scheduler_init(dev);
> > > -	if (err)
> > > -		return err;
> > > -
> > >  	err =3D register_reboot_notifier(&mshv_reboot_nb);
> > >  	if (err)
> > > -		goto root_sched_deinit;
> > > +		return err;
> > >
> > >  	return 0;
> >
> > This code is now:
> >
> > 	if (err)
> > 		return err;
> > 	return 0;
> >
> > which can be simplified to just:
> >
> > 	return err;
> >
> > Or drop the local variable 'err' and simplify the entire function to:
> >
> > 	return register_reboot_notifier(&mshv_reboot_nb);
> >
> > There's a tangential question here: Why is this reboot notifier
> > needed in the first place? All it does is remove the cpuhp state
> > that allocates/frees the per-cpu root_scheduler_input and
> > root_scheduler_output pages. Removing the state will free
> > the pages, but if Linux is rebooting, why bother?
> >
>=20
> This was originally done to support kexec.
> Here is the original commit message:
>=20
>     mshv: perform synic cleanup during kexec
>=20
>     Register a reboot notifier that performs synic cleanup when a kexec
>     is in progress.
>=20
>     One notable issue this commit fixes is one where after a kexec, virti=
o
>     devices are not functional. Linux root partition receives MMIO doorbe=
ll
>     events in the ring buffer in the SIRB synic page. The hypervisor main=
tains
>     a head pointer where it writes new events into the ring buffer. The r=
oot
>     partition maintains a tail pointer to read events from the buffer.
>=20
>     Upon kexec reboot, all root data structures are re-initialized and th=
us the
>     tail pointer gets reset to zero. The hypervisor on the other hand sti=
ll
>     retains the pre-kexec head pointer which could be non-zero. This mean=
s that
>     when the hypervisor writes new events to the ring buffer, the root
>     partition looks at the wrong place and doesn't find any events. So, f=
uture
>     doorbell events never get delivered. As a result, virtqueue kicks nev=
er get
>     delivered to the host.
>=20
>     When the SIRB page is disabled the hypervisor resets the head pointer=
.

FWIW, I don't see that commit message anywhere in a public source code
tree. The calls to register/unregister_reboot_notifier() were in the origin=
al
introduction of mshv_root_main.c in upstream commit 621191d709b14.
Evidently the code described by that commit message was not submitted
upstream. And of course, the kexec() topic is now being revisited ....

So to clarify: Do you expect that in the future the reboot notifier will be
used for something that really is required for resetting hypervisor state
in the case of a kexec reboot?

>=20
> > > -root_sched_deinit:
> > > -	root_scheduler_deinit();
> > > -	return err;
> > >  }
> > >
> > > -static void mshv_init_vmm_caps(struct device *dev)
> > > +static int mshv_init_vmm_caps(struct device *dev)
> > >  {
> > > -	/*
> > > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In tha=
t
> > > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero=
).
> > > -	 */
> > > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > -					      0, &mshv_root.vmm_caps,
> > > -					      sizeof(mshv_root.vmm_caps)))
> > > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > > +	int ret;
> > > +
> > > +	ret =3D hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > +						0, &mshv_root.vmm_caps,
> > > +						sizeof(mshv_root.vmm_caps));
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > > +		return ret;
> > > +	}
> >
> > This is a functional change that isn't mentioned in the commit message.
> > Why is it now appropriate to fail instead of treating the VMM capabilit=
ies
> > as all disabled? Presumably there are older versions of the hypervisor =
that
> > don't support the requirements described in the original comment, but
> > perhaps they are no longer relevant?
> >
>=20
> To fail is now the only option for the L1VH partition. It must discover
> the scheduler type. Without this information, the partition cannot
> operate. The core scheduler logic will not work with an integrated
> scheduler, and vice versa.
>=20
> And yes, older hypervisor versions do not support L1VH.

That makes sense. Your change in v2 of the patch handles this
nicely. For the non-L1VH case, the v2 behavior is the same as before in
that the init path won't error out on older hypervisors that don't
support the requirements described in the original comment. That's
the case I am concerned about.

Michael

