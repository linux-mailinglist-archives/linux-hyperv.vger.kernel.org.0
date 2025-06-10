Return-Path: <linux-hyperv+bounces-5832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1DAD422B
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE7189FA55
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADF244691;
	Tue, 10 Jun 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GNRc0ogv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011033.outbound.protection.outlook.com [52.103.12.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D72144A2;
	Tue, 10 Jun 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581141; cv=fail; b=c1PrmGCtNMfJHec2KQtS8zu4iGs2LWFTw3WWZDhQ+yHKs49N70odGMFnfcHkXc7oTSCqE7LE4sIHLDRBMpqvZ8kFNpOUQ/xBBz2Dc0lSNDPSICPGRa32Mwuem+8T+IG4FQ/t0a05rgjb3G3VXwkIYywDpPHHhH+W9p/aGvURxe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581141; c=relaxed/simple;
	bh=Zsz6MTqXmBYeebKFgJNC5KtnqIcl7LxguRdwqKF6JNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rL5JvDN6MAjDpvV0JOCOCei+7WiXjO8aXkhbSHz8C74QwVH6d4chwr0MXtdfK+BTOakoR0aCwc3APAKt/vmZQ7lBrsOovNcx764nuELmiFYFUaDBj3c/aGvQ2tEKaSh3eQef/xsoIh1zWm/CKz4OCcz/TEzDWT4IKQIbWoYy+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GNRc0ogv; arc=fail smtp.client-ip=52.103.12.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9gT3vvlcx7MhMbZOCiXZXfNSD9DHuKf9AtH02lkKvEd5hY3k6DY9U3CRktVhWKirDKGpfkvUOWgo/Mr5Zexvbsi0Vb5+MAKYW/vEc6HmKXbEVmTL56MJTf++oOCVvhLf2q2UvKWSrkqZHf/lxtWXFr7XnTjKvMGASFs6oCVWTu2ccii7gwuiQbxiyCEJG2iPCK+K0pZJiNMBZ0bAH1DlUR9iUtJxTkroPBawuTbhgsH502KNRxscIzdZpEkwEf6sZthYJQg/3uOc7P6QIOH43CPfwOtjTEYEUOBJMJOngjaPEInjaDu/2ECUmBY8Gj8Erygqf1CAsi1DIF18jo72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaKRFNsrxNiM0WbTuOhtXwXvQexP0LD2NHwlLsY9jWc=;
 b=kUCtfBbj+MV9MMu+Np6gevpIZBF6KWMheAVS6w1Ejqd1QFkO0Ve3QTCZGFC1+QJzHWTjNoxfZjlRy05e6Y5NWcwNCFX9oRY3UGCRuJ0I7zZGvTE+aefSy/kw6W+Rq/OC//MzaKgLPcy4JMBV9i1JwQbXFYfbMliGWgBBcQEsGRacQ5WbnulQT8CB9Rv3Z0JqZfJmH61vvJmTWSn33gZcdzJLrlhUfrgkH/1WbS0dNnXYehkNmevDAqhjBqDchM4dkIO8/+VWBnkzyJl0+S1IaCqIP11iGLTFT5GVbIEQGMdx0o8LScYdu3sf7h7y+2USxBxKPM86MPrmw3Bx5A8uVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaKRFNsrxNiM0WbTuOhtXwXvQexP0LD2NHwlLsY9jWc=;
 b=GNRc0ogvzP96Op/YlNiGTMuzE7l2Dbrn3PmjCUYp1eDhwtjwjSTgDk0TswhaIFntAWS5pQZQCxgik19AqfpZx1vwP0/rKDfOvutatgUE6NUGQ+v0kDWA0EHvI9Pe23L/QoAaxl80HFmTaoltNZBx+7mEpB50Tae4vc6ERczLjbu3By4zS7tMTJwT7YN9xPf0qdqCwLex0+vJO512g9I+a7aRmGSxKdIUV5gfnOYnkhRQNZpY5FgcC0QYNMfShPAFSdO1uMxeFcjtjFyK5GVZQOMhiFSfdB08Ri+IMov3gRBYj2/XK2hHOkKynaLLJ/ArbPGQ+QfuwS4WwyvBo4gA/w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9596.namprd02.prod.outlook.com (2603:10b6:930:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 18:45:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Tue, 10 Jun 2025
 18:45:36 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>, Arnd Bergmann <arnd@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH] hv: add CONFIG_EFI dependency
Thread-Topic: [PATCH] hv: add CONFIG_EFI dependency
Thread-Index: AQHb2eia04zHIDnue0WZOFD8f2qY5rP8hlQAgAADWgCAAAFzcIAAKcLw
Date: Tue, 10 Jun 2025 18:45:36 +0000
Message-ID:
 <SN6PR02MB4157D3A61C5DB1357267D712D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250610091810.2638058-1-arnd@kernel.org>
 <20250610153354.2780-1-romank@linux.microsoft.com>
 <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
 <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9596:EE_
x-ms-office365-filtering-correlation-id: aeb6e2e1-819b-4943-4863-08dda84efd6b
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYDUdQrXdfZM8z4VcKytxXRHGF7V5Kodw6uiq52/cK8pwfRzLFICn5blQImeVomO0sFxL0Pn5iyRLxS86za7Kf6g0dTpLd66yAFI9yvGb3WPWjQQSlv+q47PNzRa3ml6o3ltaORu2JLTxEc8XQ+C5TYRTSiriZ9tP083/C9XdOM0djwAsKJ8nA8Sduj7/aUW0Gw259CE6HvfYpw06k/zucZ2lDffbEZjxzkJVXGdqBUVPuLdKGPT2SLrloFNaP04WHJclMpUfTAO5Q+pFcv5kfU+MT14Z/0FaS+WR4Dq+5J/wqNnnDq72JghaQBlIxzC53HgUGGtafCWaOLqZXOdzeyuCwb56Bf+aNZ7bEewM8w+1zjT1ikTKYG9nKba43frGv9DM6ytBpgmexau4hZvSP3tPl4aeHgsRj+wVDLGfa3Ev5hJNdhSn16RXq91lzaHKKnVRew4BKltb2zBd83kuoSY9hBxfQbMMCwsnGl/vf/ugdMIR3Hn6QESPfKuzl/1cpjBk0nlkFUwdqE5Cg+nOd4mwexIX6jWsOU1aoXe9YXXdhgDRkZu4YHLf7qFjppWLCvg0wIfwpJFdOUgGREUbBKuX8Q++oT5tBn9nf4ASrVN3zAn75D5nWvTFdszFEh+Hd76ZvIxJbWBclq0PLz1IEEFpeTtVQh8pqRA72HUAr0b5Wg8tdYfD3Q/l2X0J8P7VUdeCDGu/+ZNWSEk/ys2hHCNPR5mHSJP2r0On4NIDa1rPP93v5LOTGjOLIpNvGiIaaWWC7CjJ1U9q9gNEggjRXN+VTokDCLNciytdaPLOCDQjdmyTfU9j/3Sd5HdG8syU4AVblG+YTaIEQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|19110799006|8062599006|8060799009|461199028|4302099013|3412199025|440099028|10035399007|102099032|1602099012|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J/hb44lEMtF1mt0GFzIb1LUI/hr2HgpQy8OkNcpYTpQ4qz8eWuVRulnBqdgo?=
 =?us-ascii?Q?8Jy8lXyS0UuTxQmTUOPrwERHywalUG4v0lswnQpsfCMcKJWmYZz6+6cw57co?=
 =?us-ascii?Q?8/j0B/CmhU0WOhAcYYHfdOWm+3ffVaftquM0ibZX1B+66ooWv/sO2YLt2DOk?=
 =?us-ascii?Q?oinReS2hENptl5Uyb/Z/YNsmRh6KUfBEigBc4/MWuTue558MiL1y0yh0olrT?=
 =?us-ascii?Q?ig0s0s11IKzkUUl2IqsKohkPStBn+7hpiD6hq98H6ZgsN3DpKY4ukB4FqKow?=
 =?us-ascii?Q?bs7QPaXUsp3E8wImBEZWqXtn4QuWxcwLYmngtzobKVbC4vn5aY4HXetykemw?=
 =?us-ascii?Q?fNbipSRGnkQ3LaBR5Kp/ard9WojN0D2rO/xcCUiZbpq/JYuUSFgKK9yYk9DK?=
 =?us-ascii?Q?aNeHlWR/LcAk9dSRrKzYoMZXFr+B7Ubx1U5scVr4K3iiuCY1jWGlIY+RVR6d?=
 =?us-ascii?Q?+ytrc2d2aIJ5BkTc5JgHiabGfyxPn8iX6WUVN53eC3QbaXUc/TN+kEVKOngV?=
 =?us-ascii?Q?gZBu6Qi6Qnbr+Ds/O4X9eildBmSapTFohuJAwlkYvvP4rdjQHI7bw/OURirq?=
 =?us-ascii?Q?iXpM46Ska9Og3sl3p7ER0uUB2RPEABBp5pHNHjTV/7udfhzC8O7aZRFu8aNX?=
 =?us-ascii?Q?H4tOPU/DZwn2hK/9a9keHGfmZzZyG9u1Ew5wkqNbzmAFdZM+jvz3wRV6TnuL?=
 =?us-ascii?Q?QS9HBvPY2pLx63zUNc9pFB3nUKWYTqfXh+XWFazLLLN0ed+tL/4cGEGQeWa1?=
 =?us-ascii?Q?XexdT3Dl/v9qAHeaCyAlqUi6k0XMkLufWHggYL1HynGSntyT1fZo9Nkc6jhc?=
 =?us-ascii?Q?FgmiYuSUWl49kwiUbPdIBepLa6UBIjfXcNyUzQ4T39UpcCPqz8B7ccDQ8mwB?=
 =?us-ascii?Q?70vkQ21RVOegsDilb8klGGylg1yC3lD5t5F3pGiotF+zxK+fa1kIfhecNsiP?=
 =?us-ascii?Q?PtVyv3euqw1X9+DDVRakqHV1dgAsz7SO4fQh4O2jDL89JMaWkWNgcQLW0Nal?=
 =?us-ascii?Q?Wa9WR/Oygq5kUbq+Zota1z3RcjRp1+lziSS9Ujel5XIO5dB4Y1se5QzfEPz7?=
 =?us-ascii?Q?M6PuWHCvulYRgQfSWuqdw7Gd84mB/FLDxEQGJYCCwYYS8HSU9A4WqgvFPXl7?=
 =?us-ascii?Q?miLLKkOElg9vr4WFzBlu/Tz2FceHEFlUjqZF0lUAihkdPQMYaMd4KI9iVomF?=
 =?us-ascii?Q?kXWrsMyIQ8jD8yEnfA6PAkzyWB6oVAvmSBLcCvYpPVMmza58QmkjSM7u+pMa?=
 =?us-ascii?Q?vWSkUUbwWFB5gxf7PBbqNLQk35PFZANq3CV9LW94GA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?whBZsSTreJFCCJ689HdtvULVdaHH116u+IDboLfhnFOj4YXS3Fq1cd6OczV4?=
 =?us-ascii?Q?BSFsoHSDkrqzPJ8B4v7ywcC8k+q7Vct9Me/eIVIbH9Pd2Fk4yU8jziR0APg9?=
 =?us-ascii?Q?7VsSh8AIv2jFOmA6cWNyPKHtXVkDhiy46aYwgjckGnGq8iIj/Ibr5s65hgYh?=
 =?us-ascii?Q?RPbcmPna3FXtolhekb1hYOBixubMpALm/kFFwr5FoxXwWGaCZSy6dcYI3Xg2?=
 =?us-ascii?Q?tyAVXl8IB/RBRkYyZLyuK2yhZKDwCGaupMTx82QQSkt5ANDjr8NuNYuOeAwU?=
 =?us-ascii?Q?Bdtw2r2PDtW054Ol7vdw+4Y2KxAKye9DeYpPPvJ0KF75n8wDjbJMW7sIH6ZG?=
 =?us-ascii?Q?1hZCV5E2nhK2NxB/cu4bspsTH8UiXU0MTq4XE+/nEMUdGiU1LgJTq+rXe66k?=
 =?us-ascii?Q?++xnY+rhPdB09H/yui6kkWkS4LZqEVPN01VrBAkElH8+tRuhu6YKZLS/4GQH?=
 =?us-ascii?Q?EiXnaX4wxOICGl7uuwyO4ayIPD02j1iZdmmFCI7UxL9H81e9Fs8/SNTmadh8?=
 =?us-ascii?Q?d1D+m60GihOzTLlQUKIY8E0Es70TIG7oOZyCM2M+c1waI531vbZGAP0UG6ip?=
 =?us-ascii?Q?WnCGwVZK5RKgSCRkakjIvv71SMsr0EW/H0Gl3hOAnaqsNev+2vRzYvaul82t?=
 =?us-ascii?Q?WJr71+3cj4oTewUZ3j2vPQuUAt117jMulI+bNd8UvvBiSbxBxvbFtxU7UQVy?=
 =?us-ascii?Q?aPTely8gQMsmO9rR/ixRom2xMZwHWVd48lJKDcnbP8YgzIt7NTIVCJjCYZX3?=
 =?us-ascii?Q?OP3oTAuNSEXLl83a6Kb5je7dLRwPpP79HYPVdIS9a/bOFUtk0f5W5G6BGvcy?=
 =?us-ascii?Q?YA7zEGaLe8wHXHLOeG7uPR3tSMz1A969aE6GAbojD5dmDNWydWcQ8H8DoOVA?=
 =?us-ascii?Q?vQn/cL9OrxkqQqQkrL7TCQX60O47b1NOWzv7uw8buSBfoQPu2pN6lZolHTDN?=
 =?us-ascii?Q?RtYy7+RSbV7Vr3RI8SWSUrI7ccHrOqtES2fKtNKeXT9Bcv2wUXdjpXH0g1TC?=
 =?us-ascii?Q?CQ0keR/X4iqVjb71xtKP56S/DnOerknt+Duze6CuOGOjs0SxscyBqMJlRzQ3?=
 =?us-ascii?Q?ZwoPem9KdL+j/wSwHbL2NQLTGgg6VuEl+x2X66WgYf/Nf7eXhob2jeRxttdV?=
 =?us-ascii?Q?3g6r7dgwoLIjAWB348R25X1rutpw++psuXqNXbhoVLmZ+lh6PgJdZQtiBBWh?=
 =?us-ascii?Q?BYLbSJZ4Kss9WZFIuGDXKl96//DPvrTF/QxSjw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb6e2e1-819b-4943-4863-08dda84efd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 18:45:36.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9596

From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, June 10, 2025 9:=
17 AM
>=20
> From: Arnd Bergmann <arnd@arndb.de> Sent: Tuesday, June 10, 2025 8:46 AM
> >
> > On Tue, Jun 10, 2025, at 17:33, Roman Kisel wrote:
> > >> Selecting SYSFB causes a link failure on arm64 kernels with EFI disa=
bled:
> > >>
> > >> ld.lld-21: error: undefined symbol: screen_info
> > >> >>> referenced by sysfb.c
> > >> >>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in arc=
hive vmlinux.a
> > >> >>> referenced by sysfb.c
> > >>
> > >> The problem is that sysfb works on the global 'screen_info' structur=
e, which
> > >> is provided by the firmware interface, either the generic EFI code o=
r the
> > >> x86 BIOS startup.
> > >>
> > >> Assuming that HV always boots Linux using UEFI, the dependency also =
makes
> > >> logical sense, since otherwise it is impossible to boot a guest.
>=20
> This problem was flagged by the kernel test robot over the weekend [1], a=
nd I
> Had been thinking about the best solution.
>=20
> Just curious -- do you have real builds that have CONFIG_HYPERV=3Dy (or =
=3Dm)
> and CONFIG_EFI=3Dn? I had expected that to be a somewhat nonsense config,
> but maybe not.
>=20
> Hyper-V supports what it calls "Generation 1" and "Generation 2" guest VM=
s.
> Generation 1 guests boot from BIOS, while Generation 2 guests boot from U=
EFI.
> x86/x64 can be either generation, while ARM64 is Generation 2 only. Furth=
ermore,
> the VTL2 paravisor is supported only in Generation 2 VMs. But I'm not cle=
ar on
> what dependencies on EFI the VTL2 paravisor might have, if any. Roman -- =
are
> VTL2 paravisors built with CONFIG_EFI=3Dn?
>=20
> > >>
> > >
> > > Hyper-V as of recent can boot off DeviceTree with the direct kernel  =
boot, no UEFI
> > > is required (examples would be OpenVMM and the OpenHCL paravisor on a=
rm64).
> >
> > I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
> > are orthogonal concepts, and I had expected that even the devicetree
> > based version would still get booted using a tiny UEFI implementation
> > even if the kernel doesn't need that. Do you know what type of bootload=
er
> > is actually used in the examples you mentioned? Does the hypervisor
> > just start the kernel at the native entry point without a bootloader
> > in this case?
>=20
> Need Roman to clarify this.
>=20
> >
> > > Being no expert in Kconfig unfortunately... If another solution is po=
ssible to
> > > find given the timing constraints (link errors can't wait iiuc) that =
would be
> > > great :)
> > >
> > > Could something like "select EFI if SYSFB" work?
> >
> > You probably mean the reverse here:
> >
> >       select SYSFB if EFI && !HYPERV_VTL_MODE
>=20
> Yes, this is one approach I was thinking about. However, this problem
> exposed the somewhat broader topic that at least for ARM64 normal
> VMs, CONFIG_HYPERV really does have a dependency on EFI, and that
> dependency isn't expressed anywhere. For x86/x64, I want to run some
> experiments to be sure a Generation 1 VM really will build and boot
> with CONFIG_EFI=3Dn. Then if we can do so, I'd rather add the correct
> broader dependency on EFI than embedding the dependency just in
> the SYSFB selection.

I've built and tested x86/x64 Generation 1 VMs with CONFIG_EFI=3Dn,
and I don't see any problems. No build-time EFI dependencies have
accidently crept into the Gen1 code paths over the years. Since
Roman has confirmed that VTL2 images do not use EFI, we could
express CONFIG_HYPERV's broader dependency on EFI as:

     depends on EFI if ARM64 && !HYPERV_VTL_MODE

which would allow building an image without EFI for an x86/x64
Generation 1 VM. The newly added "select SYSFB" entry would do the
right thing and stay unchanged.

An alternate viewpoint is that we've always built Hyper-V x86/x64
guest images to be portable between Generation 1 or Generation 2
VMs, and that allowing x86/x64 images with CONFIG_EFI=3Dn for Gen 1
VMs only isn't necessary. In that case we could just add

   depends on EFI if !HYPERV_VTL_MODE

I lean slightly toward the first of the two, and not requiring EFI on
x86/x64 if someone really wanted to build an image that only runs
on Gen 1 VMs. But the downside is that someone who built such an
image might be surprised it won't run on a Gen 2 VM. Anyone at
Microsoft want to weigh in on the choice?

Michael

>=20
> >
> > I think that should work, as long as the change from the 96959283a58d
> > ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests") patch
> > is not required in the cases where the guest has no bootloader.
>=20
> Yes, I think this is true.
>=20
> >
> > Possibly this would also work
> >
> >      select SYSFB if X86 && !HYPERV_VTL_MODE
> >
> > in case only the x86 host requires the sysfb hack, but arm can
> > rely on PCI device probing instead.
>=20
> This doesn't work. Regular ARM64 guests require the sysfb hack
> as well.
>=20
> >
> > Or perhaps this version
> >
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -19,6 +19,7 @@ config HYPERV_VTL_MODE
> >         bool "Enable Linux to boot in VTL context"
> >         depends on (X86_64 || ARM64) && HYPERV
> >         depends on SMP
> > +       depends on !EFI
> >         default n
> >         help
> >           Virtual Secure Mode (VSM) is a set of hypervisor capabilities=
 and
> >
> > if the VTL mode is never used with a boot loader in the guest.
> >
> >      Arnd
>=20
> [1] https://lore.kernel.org/lkml/202506080820.1wmkQufc-lkp@intel.com/

