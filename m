Return-Path: <linux-hyperv+bounces-8961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDJGHgTBnGmgKAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8961-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 22:05:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F617D580
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 22:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D902E314F6BD
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE3347FEE;
	Mon, 23 Feb 2026 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cEryHmpt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010088.outbound.protection.outlook.com [52.103.10.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03244296BDB;
	Mon, 23 Feb 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879781; cv=fail; b=V8utlF41F9yYwRDD0JxlstjYZA3sbiAyTGOSzQM/OhnT+Bx2YTjFRKcPd5R0wN60FhZBI8/hZRA1h2ySDoHdPAxQUNPZBYZ7lI40bh579cZqqI/ldWJ4TzHmRx3vbhFMxCDCdTGUOywP6GeDUT1iF6Pc7e99R5u1xf93ePcjx5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879781; c=relaxed/simple;
	bh=TfYhB7HJFZ0jG1P1IOuJi4ofHyR3GWDiDkU7mchuQlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSFDzU0smqP3HHLs7+r5qDO6CF2jDT3uN1fEV3FKSQf2VtMpyf+eogHhUNVMkWwkIWt3GYVXtvAjhDIWR51QslTHbtMEcgSSoo8VyWbpz0nGt47Sn4vLU/Bv1MEGgtevMt1sK59wX0THJSXV15iHRRaZCXaTMoZq8F2/sTt9LTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cEryHmpt; arc=fail smtp.client-ip=52.103.10.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwMx+7luvvUNcFF18afd6lPPruDHRc6+f96187bQVsfB0H07mDTtosgcLanMXRBiNHEIFsWuNlt4O94ud7ZI/ENgJxW8TtJ1/zPTjQOA3HVegblXg2YNXYOjvoG64qg2nZghs7HKYHDFkliyAVqFg4DEMBhVlLiNPsr7Av2PkoFDf6Qto7LwxUyZulHWY1kRDa8jdlfL+XThtqfVKQcHG/DFrtl9Z0b27qDfQ8TpFRY9pYPuelbFe4tyYjD+g1UJFegHISy5aiH6u7iFUpVUx8mipUyxfgC2vGznDpklAVFPpL1GEwc9Yj13VpFApj8GoRtXGWwAQ8OS4bu6he8uoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61GQi1I9BKBx299uxdC6PVcNNkjjIV1Vmzex92Nm1po=;
 b=uRV96YqmGqhJI1fGUk/V/dhwUq1NAot63Fah/HRB8TMu4Q6xKus6KBmlVPcUSoBkLbYU37zp4S7pDsl5vG3zHzizI1tKlqrnposNVqCw6dBmBEvXQtpck4X+aNRWvg5qmtFNc7yO6jSR9IFz+csiPjA4oWD/2pEx4SddJ1/nWnac7Kk01BvBevbwhCj12paOlIApw87p7/CsL6C0Mc44jmnglYZ227+tnaRxIlduT57fO1coHHmexAVoPNLrx8xW1gRoaogW/J7Xo/Xxu6qFNtcKvIy6jfM6yV5iik7oMw39CbR76nAH/BuMcy40bBuXtE9KetO21Ge8RbSe2TbCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61GQi1I9BKBx299uxdC6PVcNNkjjIV1Vmzex92Nm1po=;
 b=cEryHmpth/PFz49sJtY0F2V0D758PN+xq7n9a6kp8x4TQc6JdNwAcqD7HMbFkqAf5rgFL9R32Ln9/j3vjJ9dZWmK7OIx9bIYlXywRzT3fngOdL1zQvyhY150t3gV5fI+VwMDtatHt/6xjeBLol2PG+RqqZhbIns6QavfgQZkt06tPGTDHFtk2cbh6UYeRfoLAeAsW34mOjRtRvs1NWgwcqKteJfp5w+uyjFsv8wcyjgZwOBtCyRhX/dqno3kGufKKS3RbIEppMmgKqy0jr7MVGDbl+YrfqALumlW9Vjo7o8gMca6iKEKan4B55bkkS8uHyyGMAmffeB+QlZYsfVxnQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL0PR02MB6545.namprd02.prod.outlook.com (2603:10b6:208:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 23 Feb
 2026 20:49:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 20:49:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Anirudh
 Rayabharam <anirudh@anirudhrb.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Topic: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Index: AQJTDlaDOFo3gBQj34wHN+dR2dNA6QJF0vEbAiGxMV60gK7I4A==
Date: Mon, 23 Feb 2026 20:49:37 +0000
Message-ID:
 <SN6PR02MB41575AC771D08F64AC00DC17D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260223140159.1627229-1-anirudh@anirudhrb.com>
 <20260223140159.1627229-3-anirudh@anirudhrb.com>
 <aZys_5A657AYq5DQ@skinsburskii.localdomain>
In-Reply-To: <aZys_5A657AYq5DQ@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL0PR02MB6545:EE_
x-ms-office365-filtering-correlation-id: 1bce4380-04d4-4eef-e5db-08de731d0f50
x-ms-exchange-slblob-mailprops:
 5fu/r660v9OFyJ+CxyO6ueseEO2yHaMVcD6rA5FbAUGs0UjvEuCgq+s7edsrhGxWjflZrRgYH0qL+UfgOCRoKYatsO8ihxKJBLb6pGAFksd6+6WvwBXZHfOJckYz7ww6ApVJbCkEa2iSoIKLM9XpLf+mu9ekhpjd2GplQxLY89Tkp+BrNRlxLX3Tuu+INrZVyv9K1cH5O3PC+1UQULyyLLT5uH1Z6lkHUf2ZPpZC4x1zFbruzL1OSBPYurSrJ37W9qQKL6aMf4gCMyQ2WHdurNexQTRpTZQjx08bO4UfGvhQmYHPqTibwF4PV/48CVVEVoN7yPkJyx/Qj7A4ffnxSmt4BzBrNtEId5cYSzdcfr7sE1QvqSWE7rEhA5/yTbuLknF9wrKtUk6kloQdIl6MiPaEfdWT9qabmLPkC4F1RGdGczt+cpVJTYsRgErhoHfyOEVckXxlXOJHiSozJXMqiJfF+0ZXEchGs/8e1kre6sc/+B0SLt5fOcivOFb1xRABh2bS0rnJRixUK0DEYdKpFJOxRxwTPZX6X+CRCp/7qef4B+dux+ywRxxLGVnvMRfBH2M/fyzseKqG5MMDX7lFDh9epcRDNJQP0gj0akhWN/30L2lJue4uoExDLl4mpuIHzEPTaSr1u58T8JZATvORn2LWi8M/BJ9npu9LnV7PjOxICu3d3xUYwWgkFbNIyUgHRY0smkFYysUQJezdAnII7WBTOPPGKOe/l/0iprFwOkc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|51005399006|461199028|41001999006|31061999003|19110799012|8062599012|8060799015|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j8Pi+aRwPKLeLQRd3sJRYALhPYWnCwyLfDfXPz0dBL/FeEmrxAdXB69sMVlL?=
 =?us-ascii?Q?R82YJHVR8920yCUXWtQuvWjxCoaG9o/SQBTGiPiJE12oQ+h0W0BiX2FxbG3y?=
 =?us-ascii?Q?+UFTCm34xyUEW+uLWM4dkOptQgZmqjsdHI0XrwPecoWe5bGVAaXN1Xb/E6q/?=
 =?us-ascii?Q?bOsn8o9WSXkiczbAICPOCuFPosMTBm8IA3yKtikMslT+tzgIjHPPMKRwe/cP?=
 =?us-ascii?Q?Ps2eImqm2A/MQfT4myE3w+frjiqf0ztxhCVn3+do+JS2nNFi9rlBrSouaDA1?=
 =?us-ascii?Q?W6qQgS3BF6Maj/HCPxGN3shypZr94bbPWIVz1MA1sqD/Uyj1+eHkj5ZPuHlH?=
 =?us-ascii?Q?g057m3FKC0Tb/8GwLxnTQoWI4Jd5GVZdBDTRbQO1qruuWjf4NfZCEaIJ/2Af?=
 =?us-ascii?Q?QWvW+HrfAMBtDZEuTkb8hrkopp8PiEV2qPhXJEOQoRm9RtF9gOAKl0s6vOc7?=
 =?us-ascii?Q?2+QGzl7H4gO1rXtlAu+yYnCic1n8hHkLAq3zhoTaVyz/EvVzGVZME3mLUxJH?=
 =?us-ascii?Q?tPas84lfADNll/7Frv1eJ9A41NJY0PuDFJMahVFN1UWgXEjSNtkg2BY+NBBu?=
 =?us-ascii?Q?4tR/kpzX/y+853Bp9fvHZlcHs8yNBb+vGAfm/FhyMlsTMnZf0nu2bg3MQMf6?=
 =?us-ascii?Q?0511frmH5OiNLWEUnUF9SmkE6ZNcbhZYubxZFjPlCNgfcpM084Hf+2fECex7?=
 =?us-ascii?Q?4u1PlDEMptODmTaWneROGWIN3Pzjc+SMyuQtXV0q6fc55SxyIkrC/glOE6GX?=
 =?us-ascii?Q?NCsEoS/JDRRVpWfFuYVNBIDk/Ry7qqHFna4dxCVLj1p/1Zkmbt3eRM7XzrNf?=
 =?us-ascii?Q?Mp6koq7JA8rkP7nhqDWbqpJt38LyJlY0fsi9KKIC+oce5kkBH2ezAQK5xcBW?=
 =?us-ascii?Q?4FuPC8B5h5pzHyGpp9mGyjaeD4Uk2cr2Hz1CzABOV/6KGw9happjZhiQCuwt?=
 =?us-ascii?Q?QSPRNsmuBtPizaKqKTNz2WJsya7MGwcz2yr+PMiTveorFFnUwcb0j7RrgG3Y?=
 =?us-ascii?Q?nVb3YSjNHTHez8UIYElBSwt3MYNq9BZkLI4LI1SuhWjAa32Uhiux8JX6SoTO?=
 =?us-ascii?Q?2xekzdIQw+U2tzTCvIusfetlYT7XTZpNDL8fCmpURq1dupgUZ/H/3OXVzlCT?=
 =?us-ascii?Q?c/jaKslaRDdU/8BPp7UE3rLo/PjpsQQIyuMTc4cIWcnTIWXQsVqEFqEKB3sU?=
 =?us-ascii?Q?Z1TZ3rknouCj80C14evIZ8BWswN4+GW0DLYmPiLY+lBjLql6KGZRfvi3mpXt?=
 =?us-ascii?Q?XODyZ47tjX+HjHWHPAk4IoeALtpauU+hXE6O35CdFQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Ce5FTyPd1KoChbFwJZL1qmHHxhcVa5wZlKaer4jooFmz2fF4yhWVDpZWDeU?=
 =?us-ascii?Q?ETlcktTTbKf+Q1jbpNVqrU4yOzyoQsw6g1GY56mNKUa3smLpDNvIvoOE2GnW?=
 =?us-ascii?Q?hYrB5Eujex2gqY53cfkwM3jmdlOdZ5FApyF+AOMF2XtEFY5WHMhoyrGc/vsI?=
 =?us-ascii?Q?13eGYzjPzZFvlXSX+cCSLv+WP/fl6KtjdE+jqEHsYRY0NUERmSsuKme3eH0N?=
 =?us-ascii?Q?2vI/SENGRW0HlwEB83Zq4/5k9/OwXE0cxXqjqkik8gfZrcDpc0N0tWtSTTtJ?=
 =?us-ascii?Q?Ltqf/DJT0qTho1FO4NJgRTuDya5dRzLWwS4FVuuK6C1BYk+8el71hgxKtPzx?=
 =?us-ascii?Q?T8ArWcgdBp9iSuq3xy6mXA0gNETKwxYl2lhQLt0WWmnmMpUQPpzD6ck0ScZs?=
 =?us-ascii?Q?sq2glEO+HRxIHhRY1Z6alr1cofFClH/xXrPTAfUAIxEOiHfU55vTX0tI26w2?=
 =?us-ascii?Q?DIBc6P1HgGnOsvQeKAzhIJjUjDvl4nM+waAM4fBZ21iM8Xao4jH3n9bmhDe+?=
 =?us-ascii?Q?EU8HaKkOKv2KiL2fhnchFULjOIq/BORjeZ/C2G3/6GmgfEy5s/xz+iiAufNl?=
 =?us-ascii?Q?+Hz33+qIMIyZuYdES4sayrsmA49Pr9A6jJEnnUg7IEvmmzvLTbPPXdorYC9A?=
 =?us-ascii?Q?6/6zgAgEud820KOIZpzSgIL80pn9EnnX/hJUZeMVWc7Np/iuOZxvkCvdFoWl?=
 =?us-ascii?Q?yCpQoIiRg+bdnH8zmTmU7KEtUmBV0e4vtmYzakP2FmdgNhQ7Ebe6s6biAqBY?=
 =?us-ascii?Q?NUGs22sQnf0x08vV1L7urCsekt3Funqh0cvdaT7GgRnPlzGGSwxEBa8T0RLK?=
 =?us-ascii?Q?gu4o4c+ycIaidUkbQDiRdHG64rsPwxMyd0RWre+vP8jYjCVdltUi542v5T+w?=
 =?us-ascii?Q?nMQCh16CJWARAnXGZJFzAnOPatLxsarTaayDzKJ19FWzZ4hJzxAfLIa0SqHV?=
 =?us-ascii?Q?kpu7qZzBUXaPyB3sGUmoYPQ6PA2GRIMwGhXKvnC1jlqlyAoORuFZTQkOF/hP?=
 =?us-ascii?Q?tjlxGTeLyW7iEdUJG7srIIT6OCnnlK7CQMEk9LnFKcXqHoWm+OpAq8QHSGmP?=
 =?us-ascii?Q?NIZbnu8moWMsSqS1T1dplNPmwPoS4cVDMqi1jmQl2l8RyvLKjdltRbl8LiSc?=
 =?us-ascii?Q?E3rLn5eddLSNr4DIQWdcyoR96Y7L7mCAoSd/4cV2HdjfsUVtgwFMd3IPGWa/?=
 =?us-ascii?Q?BxrFeL+vxKDo7eB99G5d6Zf9Y0ReBo+rk6gY87lriuLxnQ9lrKJ7u40XvQVH?=
 =?us-ascii?Q?Z39hw/UIRjtRlsnb6Rb7f41dHt0fSs69Tw11sHize8PGBOrF7btTQItrnyqg?=
 =?us-ascii?Q?M9T/FkCmHhcZGeOqLOTWu7g3qrmI+u6G8is5xxXjfo3VFSaIlYbdVHgb79tu?=
 =?us-ascii?Q?4bQn/MU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bce4380-04d4-4eef-e5db-08de731d0f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 20:49:38.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6545
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8961-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,gen1ubun:email]
X-Rspamd-Queue-Id: 8A0F617D580
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, February 23, 2026 11:40 AM
>=20

[snip]

> > +
> > +static int __init mshv_sint_vector_init(void)
> > +{
> > +	int ret;
> > +	struct hv_register_assoc reg =3D {
> > +		.name =3D HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> > +	};
> > +	union hv_input_vtl input_vtl =3D { 0 };
> > +
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> > +
> > +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SE=
LF,
> > +				1, input_vtl, &reg);
> > +	if (ret || !reg.value.reg64)
> > +		return -ENODEV;
> > +
> > +	mshv_sint_vector =3D reg.value.reg64;
> > +	ret =3D mshv_acpi_setup_sint_irq();
> > +	if (ret <=3D 0) {
> > +		pr_err("Failed to setup IRQ for MSHV SINT vector %d: %d\n",
> > +			mshv_sint_vector, ret);
> > +		goto out_fail;
> > +	}
> > +
> > +	mshv_sint_irq =3D ret;
>=20
> nit: given that mshv_sint_irq can't be zero, the logic can be simplified =
by
> using 0 instead of -1.

The test for <=3D 0 is actually wrong -- it should be just < 0. Zero is a v=
alid
Linux IRQ number. For example, here's the output of /proc/interrupts on
a Gen1 VM on Hyper-V, where IRQ 0 is used by the legacy timer:

root@gen1ubun:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:         18          0          0          0 IR-IO-APIC   2-edge      t=
imer
  1:          0          9          0          0 IR-IO-APIC   1-edge      i=
8042
  4:          0          0          0        792 IR-IO-APIC   4-edge      t=
tyS0
  6:          6          0          0          0 IR-IO-APIC   6-edge      f=
loppy
  8:          0          0          0          0 IR-IO-APIC   8-edge      r=
tc0
  9:          0          0          0          0 IR-IO-APIC   9-fasteoi   a=
cpi

But I see other places throughout Linux kernel code that treat IRQ 0 as
invalid. So I dunno .... But it's probably better to treat 0 as a valid IRQ
number.

Michael

>=20
>=20
>=20
> > +
> > +	ret =3D request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> > +		&mshv_evt);
> > +	if (ret)
> > +		goto out_unregister;
> > +
> > +	return 0;
> > +
> > +out_unregister:
> > +	mshv_acpi_cleanup_sint_irq();
> > +out_fail:
> > +	return ret;
> > +}
> > +
> > +static void mshv_sint_vector_cleanup(void)
> > +{
> > +	free_percpu_irq(mshv_sint_irq, &mshv_evt);
> > +	mshv_acpi_cleanup_sint_irq();
> > +}
> > +#else /* !HYPERVISOR_CALLBACK_VECTOR */
> > +static int __init mshv_sint_vector_init(void)
>=20
> nit: `init` is usually paired with `exit` or `fini`, so maybe `cleanup` c=
an be
> renamed to `exit` as well for better consistency?
>=20
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> > +{
> > +	mshv_sint_vector =3D HYPERVISOR_CALLBACK_VECTOR;
> > +	return 0;
> > +}
> > +
> > +static void mshv_sint_vector_cleanup(void)
> > +{
> > +}
> > +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> > +
> >  int __init mshv_synic_init(struct device *dev)
> >  {
> >  	int ret =3D 0;
> >
> > +	ret =3D mshv_sint_vector_init();
> > +	if (ret)
> > +		return ret;
> > +
> >  	synic_pages =3D alloc_percpu(struct hv_synic_pages);
> >  	if (!synic_pages) {
> >  		dev_err(dev, "Failed to allocate percpu synic page\n");
> > -		return -ENOMEM;
> > +		ret =3D -ENOMEM;
> > +		goto sint_vector_cleanup;
> >  	}
> >
> >  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > @@ -713,6 +810,8 @@ int __init mshv_synic_init(struct device *dev)
> >  	cpuhp_remove_state(synic_cpuhp_online);
> >  free_synic_pages:
> >  	free_percpu(synic_pages);
> > +sint_vector_cleanup:
> > +	mshv_sint_vector_cleanup();
> >  	return ret;
> >  }
> >
> > @@ -721,4 +820,5 @@ void mshv_synic_cleanup(void)
> >  	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> >  	cpuhp_remove_state(synic_cpuhp_online);
> >  	free_percpu(synic_pages);
> > +	mshv_sint_vector_cleanup();
> >  }
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 30fbbde81c5c..7676f78e0766 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -1117,6 +1117,8 @@ enum hv_register_name {
> >  	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	=3D 0x0008007A,
> >
> >  	HV_X64_REGISTER_REG_PAGE	=3D 0x0009001C,
> > +#elif defined(CONFIG_ARM64)
> > +	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	=3D 0x00070001,
> >  #endif
> >  };
> >
> > --
> > 2.34.1
> >


