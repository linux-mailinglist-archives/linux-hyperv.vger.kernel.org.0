Return-Path: <linux-hyperv+bounces-11160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO4qEHTHEGoudgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11160-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 23:15:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF6A5BA483
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B67300D705
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587E34B437;
	Fri, 22 May 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oq5wigqt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FF1DE4FB;
	Fri, 22 May 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484170; cv=fail; b=DQY4AOJpLUwbbF6x7QcG17zN8J3PTTe9sgxB1onVrywYQqQTESjrbZV7PHMzKsS64T+YO9ZKCc+gX3fMc/CWuvkSLTAfFjBA4ycFtEyWHs/N49H6imZkaX+LSf9oprrrrisjh0FRAiR2Ey/jjz8B+xjW82L2+j3OwRmVwnMGmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484170; c=relaxed/simple;
	bh=4/r+cD5qGqpGAvrQeJBQLNHeeRl0JOcbMp5TuRoIk1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nvA3RnI51Ls4Pv/kJf8CsMooAosZpbkao0pKSJDfZ7sURTfvzhvbp82CvLXxwsp5QDV9nuZTcN1SM3+qGij+Www+5AcRNgYt/LMUgVzW9D3AD8GVX5ywnCQbSU2v0e/qZvvdlGcyUnQp2d7BJ8gP6S1xrUgQbA6QV373oFO1jaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oq5wigqt; arc=fail smtp.client-ip=52.103.23.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZeyLMdpwA3qqK2fojKsTKgNEuwmbqT8jkJyKbYsccvwvqqODWW9AHCO0EjQCcmFZvgPAiE5RSMaCIiFL763ze3RfYH7zTaNfd+lhBmwnHaWSds7pDvth1XwYg6JcZ7XYsh3BTK7kNVyX1fb6JP3SpPekI5DPICIixNTnysJQSwkQjr3XpEqQRtqsTUAbGawHJj90mnbvtoMScvdJApodGWcxTsOkW7G/BvzscdHRfbyCUb8/6eOIqe3PEFWIl4otaTXSyzOOvLeUXKrcIJCXnW2qJVL7cYrkoNd9Ys7ZPFE+0mdFHRT1a/xMhB5eULxBT1dkuncEqlLBXxut1X84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2TnDKcc+4NUMR/zPoGaHu9KP1pUj3ubK38e0wxwi8o=;
 b=bWmIW/dJ5mjgFrtTkK45ju2geGlcdo8C2qJyRtjALmfCAI5SHUtlST3UbHtBr+ffn0QxV1A72r2C8pmspaomkHPZHGZBbK8ow2zLZtKKpDn3OFGBRPqTWdOzjvXB2Tk7oyqZqx4i66qkK6OcPRcqSiqxhA27hnZ61K+qbyP0DQR+7uYgdK18HBXHJ2Lgtdqo8IpNGb7z7YLCD6jfUEtxUhkO1pfgUUIzYZ9KiZHQT7vUGQj88LSSr8+t1cw0vzqdwBxiJnGqS18/WVrv/sKD96N8xUVI+G6rZfrNMnUgPAVlN8o3/I398UeLjljDgUmvu2yefYRz46ZSk96pQ0dPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2TnDKcc+4NUMR/zPoGaHu9KP1pUj3ubK38e0wxwi8o=;
 b=oq5wigqtT+3ERMGrUkwIqbwC9OHODjalLJADThwTcvo3L+ihWz7DO3cNohYJVihIx+9kvo3rK62YrRIAVLklPjqBaflC0hfl0Z56HJqgkBTsJ2Vd7i2C0HM5n6SpD9w/gYNHxbqudZSKyHdfmuqi5TiaTP2OEsm2NbOrafouV/lrsUa8F1NjZyAPWUeEWj/pq2kyKu8TY2YlkcPOLaboUSONnVTpaPg7YZo956x5XsIymBHcceBw38Rdpsvhc+J1ZlXVFoIbJeGPDq9o97iz+mYpvTr/EBGOaYBLiqInHZ7JBemlAcl4zJJoXAznT168xRcGm0GkCe7O7MiNY6QU6w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8646.namprd02.prod.outlook.com (2603:10b6:510:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:09:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:09:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v4 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Topic: [PATCH v4 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Index: AQHc6WRTi9sIax6RGkKtl05MZf62VbYai78w
Date: Fri, 22 May 2026 21:09:26 +0000
Message-ID:
 <SN6PR02MB41578603BF0F6541979BD8D6D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1779396074.git.me@berkoc.com>
 <6e5d1d57a3afc4c5ea0d2a3d62be58c90741a869.1779396074.git.me@berkoc.com>
In-Reply-To:
 <6e5d1d57a3afc4c5ea0d2a3d62be58c90741a869.1779396074.git.me@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8646:EE_
x-ms-office365-filtering-correlation-id: 4d78516e-b8d6-41a1-592c-08deb8466858
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19101099003|51005399006|37011999003|13091999003|12121999013|41001999006|8062599012|8060799015|19110799012|15080799012|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/1a7jRU3mDGdkjbP0lHxg2lyxHfCM4XCKMaWZOaZOqgqk/dLJV8FTZJvl9mm?=
 =?us-ascii?Q?5pCGYrwv9YIJ9pF+6HI97IV5j1bxuPU4nxWIkKPixi34taUovpBn8Y/uPklA?=
 =?us-ascii?Q?1e8fJ18WdEjxmPpiNpHvySwz033oSD1nOJSbBdJ9NOpI6kXK6obbRyK3NNCF?=
 =?us-ascii?Q?qonAt5Wo4hvJvIUzn+tMbu2cJtF4Fxcrmcv8IoWweS8EmBoK5EU1q9hU/XXG?=
 =?us-ascii?Q?oiVyjNVOs9E7Q70gO1g/5LGU268/vKTI/tYnEfLRh6e62lkrjs25Qo6DxtJL?=
 =?us-ascii?Q?TWIHw/KvwAbp7GYZuyvC+frMrELVGbe6GdZ9JcBvjpxK0VnJOjptDJkBYAfC?=
 =?us-ascii?Q?AQutvwI9Kr8oRvXpznpNYPfUhjBdzJW0v3Yp0bVfiKHu2QVsh2bISPLC7DbH?=
 =?us-ascii?Q?aLs8pkk9fdCUV6dNsAgUt5BTqX/5CXrzJNelzQSz3kr81Db4hY8y+E6Xx7bv?=
 =?us-ascii?Q?yGv/y+lgZrfjWC4WRBUzQ+xQKD8YY+NeEFmI0Lez9B6P5rvTXmTpdCl7o6BM?=
 =?us-ascii?Q?bvDpyLWRUUxdlOovDmT9mGY6mAwJe7hefsyG2J26bOQWYhRRGyzl6KyN45pv?=
 =?us-ascii?Q?dHKFKf2J7yUp1PX1m3TBiK1fy3k6IlWk9584n9HJXwz6Hr86grhCqxr9fFOw?=
 =?us-ascii?Q?14qGOshI+ChgubGkZqS2N2Pol0mWKNQfByAkwqelkUjAra5bFgO8Tm5iTXC/?=
 =?us-ascii?Q?tH6CA/1fXSKFZtN0XLjr0wKGhKoml1sUDyB3S3THEosG0G0GlC6JgxHzzGHI?=
 =?us-ascii?Q?yWRy11IhvGeRf/MxmCZEQxqvDFteRIvJegGgwP9O2mR9Uy6wV3DCdNiJTVaf?=
 =?us-ascii?Q?+6hIgzEq27I0CS2L2Jsj+nMvsHKJrjcE/2MobZCUOhjKrJm7/n3dYSieNwk5?=
 =?us-ascii?Q?BuKehwYSC0ELvI+8DF54yU0rt8sKqHz+0L8nAfXLvko/rrNjljT0aVCk9CUg?=
 =?us-ascii?Q?cYCHdHSo1Z+RLdkeMhj2BkhYmAZ0hT4TYp7ziRDL+Rkzt5ocAj1somi1/gA7?=
 =?us-ascii?Q?HiSSr7nYXfVFAjegvrWrhHgvhCi9z/3HuK6z+Yk5y+4IfpXN/dy00H3C+xFw?=
 =?us-ascii?Q?joFwrzFv5KVB0p+L9tD/Va//HE90kQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P96cj/Q1+x1KXEqrAgCnqY+9GJBOgk8WpLJZ86ieqEg/cXlsv9U1O1anptz5?=
 =?us-ascii?Q?PcHP/SaOsCQ+lRi4EdA4s0fpdaqlYN5CIC0tV03w2d+ESmzQCabizzfufMIe?=
 =?us-ascii?Q?yhf3vH5loXoWK5sOLxRA2vbGF3Md6BcAY8WkVj1UohDfoeiCVJdhFuxxCJyu?=
 =?us-ascii?Q?fm+kEKbHzmOggrXlT/U5mrwDYw0fUVetipNNQjpDHvz3WvsK9FoyPc1gjV8+?=
 =?us-ascii?Q?RzpkISqefLxa2v1Mpi626iOhKJdr/dyPo0EEXpirAKt7AHQ6DzzZSqxhX0j+?=
 =?us-ascii?Q?2ejy8F/j6Bh6Gyg5qAJJYcpLet9pYDT2CZb42qFVsvtBYG08xvbXv4M1aA11?=
 =?us-ascii?Q?vY4hwSzIDmHWgLssFCnTmNPS2m+u2uLte5tWT4zaGqqixfCYMlZ/IcRecHp5?=
 =?us-ascii?Q?/KHuk+tx3egJuHTN9BdcShtQSgDYHtW0pchMCbPXsAUJjZxNjYWIEAsY95DA?=
 =?us-ascii?Q?ldgiPEvUVzVceHeDb5wdBaC0K/f8FT8+6Mv6D0cZaldMLBs+JXeAyIMA/x9g?=
 =?us-ascii?Q?rQEMsTPmpDik2d1z/quWbKgB77qnJrkVhcgWGD/l4mkH6rZjgrEEWtCGERJ8?=
 =?us-ascii?Q?TiJtYvlllPgeEHlmZavCEjOhvkhxhUZSOQQgEWNcHXOjnHpH9SHcP0rPTcBH?=
 =?us-ascii?Q?sRk03CoK+2tI1hbPZnk28PmMJTWQCk09ylfPKvSi21++1A2EFYhOymVt1BuI?=
 =?us-ascii?Q?xchGUsUHr0MZVG39PguWEmxe7iu8yP4jwYSjYbIvVWNag8FoMGSXQ3k702OI?=
 =?us-ascii?Q?mzZ7mYvh8LGORe8RfFYL5eHOeA9PTLq0BV8DgqAXmr9+P/YEV5HHsxvItYq8?=
 =?us-ascii?Q?4DMaaeuw2g38wKfgk4PiJBuw1QXp4mRMJ7UV3oKXQkLxCDacdRCJ5Ggd1XzV?=
 =?us-ascii?Q?fcwJZTdU5qi6ZDijWIX2sk3ZALhpBe0AZzpqxMaDV1dMNCkJ/mo1FyRZUJmE?=
 =?us-ascii?Q?P0z5O63Ovq9lh4LPDAandNdgRqNrbB0vQojEpBT+eNmOvNu2p0uvp5Ox8VY2?=
 =?us-ascii?Q?GXK2cy05dlFfkuve7zUyp1qaLnOwlR7i8u4fLqTS0YJas5HmdpGcaygJH5Rl?=
 =?us-ascii?Q?P1AOvuo5EUyDSghwPM5WCu+CmOjFvfQ3NKFR18ia5z5hwfNbvrE0z44yQtYC?=
 =?us-ascii?Q?RHDXrbAOvhFMWynLih8ekPTOePGbUZ8Jp/+HbLUIXjrxxNXzklye4DxNZCow?=
 =?us-ascii?Q?5m4Z9W1xsvFqotfTxS1c419zuOnunhkMMURVwjEViUPz/J1dYbr8xpb7WUOa?=
 =?us-ascii?Q?KGgQDJrhkguxHC9HUnFQD1SAZrIo7RaKy4tEerKn4eJvR/9e9ZW1fbebd577?=
 =?us-ascii?Q?gABwtRWujenHgb8y1lGNoRBbTxeruOp3xwxPIg2fFLLt4muBFFvu6Wdz3fY2?=
 =?us-ascii?Q?dTBnX2s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d78516e-b8d6-41a1-592c-08deb8466858
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 21:09:27.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8646
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11160-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.877];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,berkoc.com:email]
X-Rspamd-Queue-Id: AAF6A5BA483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Tuesday, May 19, 2026 1:09 PM
>=20
> hyperv_receive_sub() reads msg->vid_hdr.type and dispatches into one
> of four message-type branches without knowing how many bytes the host
> wrote into hv->recv_buf. The completion path then runs
> memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE), so the consumer that
> wakes on wait_for_completion_timeout() can read up to 16 KiB of
> residue from a prior message as if it were the response payload.
>=20
> Pass bytes_recvd into hyperv_receive_sub() and reject any packet that
> does not cover the pipe + synthvid header. For the three
> completion-driving types (SYNTHVID_VERSION_RESPONSE,
> SYNTHVID_RESOLUTION_RESPONSE, SYNTHVID_VRAM_LOCATION_ACK) require the
> type-specific payload before memcpy/complete, and apply the same rule
> to SYNTHVID_FEATURE_CHANGE before reading is_dirt_needed.
>=20
> SYNTHVID_RESOLUTION_RESPONSE is variable length: the host fills
> resolution_count entries, not the full SYNTHVID_MAX_RESOLUTION_COUNT
> array. Validate the fixed prefix first so resolution_count can be
> read, bound it against the array, then require only the count-sized
> array, so the shorter responses the host actually sends are accepted.
>=20
> Only run the sub-handler when vmbus_recvpacket() returned success. The
> memcpy length is bytes_recvd, which is bounded by VMBUS_MAX_PACKET_SIZE
> only on a successful receive; on -ENOBUFS vmbus_recvpacket() instead
> reports the required length, which can exceed hv->recv_buf, so copying
> bytes_recvd would read and write past the 16 KiB buffers. Gating on the
> success return keeps the copy bounded.
>=20
> Rejected packets are reported via drm_err_ratelimited() rather than
> silently dropped, matching the CoCo-hardened pattern in
> hv_kvp_onchannelcallback().
>=20
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> Signed-off-by: Berkant Koc <me@berkoc.com>
> Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 63 +++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index c3d0ff229..48054b607 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -420,26 +420,81 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
>=20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
>  	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
> +	size_t hdr_size;
>=20
>  	if (!hv)
>  		return;
>=20
> +	hdr_size =3D sizeof(struct pipe_msg_hdr) +
> +		   sizeof(struct synthvid_msg_hdr);
> +	if (bytes_recvd < hdr_size) {
> +		drm_err_ratelimited(&hv->dev,
> +				    "synthvid packet too small for header: %u\n",
> +				    bytes_recvd);
> +		return;
> +	}
> +
>  	msg =3D (struct synthvid_msg *)hv->recv_buf;
>=20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		size_t need =3D hdr_size;
> +
> +		switch (msg->vid_hdr.type) {

Having the combination of the above "if" tests followed by the
switch statement on the same value is logical duplication that
suggests to me that some code reorganization is appropriate.
Consider the following approach:

1) The drop the big "if" statement and make the switch and cases
be the main decision point. Include SYNTHVID_FEATURE_CHANGE
as a case in the switch statement.

2) The check against "need" followed by the memcpy() and complete()
are used by the original three cases in the switch. Make that the normal
exit path for the function so that the "break" statements for those
three cases still do what you want.

3) For the SYNTHVID_FEATURE_CHANGE case, just do a "return"
when done since that case doesn't want the check against "need" or=20
the memcpy()/complete() operations.

I haven't coded this up, but I think it should be cleaner and be fewer
lines of code.

> +		case SYNTHVID_VERSION_RESPONSE:
> +			need +=3D sizeof(struct synthvid_version_resp);
> +			break;
> +		case SYNTHVID_RESOLUTION_RESPONSE:
> +			/*
> +			 * The resolution response is variable length: the host
> +			 * fills resolution_count entries, not the full
> +			 * SYNTHVID_MAX_RESOLUTION_COUNT array. Require the fixed
> +			 * prefix first so resolution_count can be read, then
> +			 * demand exactly the count-sized array.
> +			 */
> +			need +=3D offsetof(struct synthvid_supported_resolution_resp,
> +					 supported_resolution);
> +			if (bytes_recvd < need)
> +				break;
> +			if (msg->resolution_resp.resolution_count >
> +			    SYNTHVID_MAX_RESOLUTION_COUNT) {
> +				drm_err_ratelimited(&hv->dev,
> +						    "synthvid resolution count too large: %u\n",
> +						    msg->resolution_resp.resolution_count);
> +				return;
> +			}
> +			need +=3D msg->resolution_resp.resolution_count *
> +				sizeof(struct hvd_screen_info);
> +			break;
> +		case SYNTHVID_VRAM_LOCATION_ACK:
> +			need +=3D sizeof(struct synthvid_vram_location_ack);
> +			break;
> +		}
> +		if (bytes_recvd < need) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid packet too small for type %u: %u < %zu\n",
> +					    msg->vid_hdr.type, bytes_recvd, need);
> +			return;
> +		}
> +		memcpy(hv->init_buf, msg, bytes_recvd);
>  		complete(&hv->wait);
>  		return;
>  	}
>=20
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_FEATURE_CHANGE) {
> +		if (bytes_recvd < hdr_size +
> +		    sizeof(struct synthvid_feature_change)) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid feature change packet too small: %u\n",
> +					    bytes_recvd);
> +			return;
> +		}
>  		hv->dirt_needed =3D msg->feature_chg.is_dirt_needed;
>  		if (hv->dirt_needed)
>  			hyperv_hide_hw_ptr(hv->hdev);
> @@ -464,9 +519,9 @@ static void hyperv_receive(void *ctx)
>  		ret =3D vmbus_recvpacket(hdev->channel, recv_buf,
>  				       VMBUS_MAX_PACKET_SIZE,
>  				       &bytes_recvd, &req_id);
> -		if (bytes_recvd > 0 &&
> +		if (!ret && bytes_recvd > 0 &&

This patch is all about detecting malformed messages from Hyper-V,=20
and the ret !=3D 0 case is another example of a malformed message because
the message is too big.  Since malformed messages are no longer being
silently ignored, output a rate limited error message in that case, just
like in the other malformed message cases.

As Sashiko pointed out, a message that's too big will block receipt of any
further messages on this channel, but I don't think it's worth trying to
code any kind of recovery. The channel is broken, presumably due to
some bug in Hyper-V. The only recovery is for a sysadmin to manually
unbind the driver from the synthetic device (which should close the
channel), then manually rebind and try to start over again. And then
report the problem to the Hyper-V team. :-)

>  		    recv_buf->pipe_hdr.type =3D=3D PIPE_MSG_DATA)
> -			hyperv_receive_sub(hdev);
> +			hyperv_receive_sub(hdev, bytes_recvd);
>  	} while (bytes_recvd > 0 && ret =3D=3D 0);
>  }
>=20
> --
> 2.47.3
>=20


