Return-Path: <linux-hyperv+bounces-5186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94348A9E3B8
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Apr 2025 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE12C3BF305
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Apr 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE819AA63;
	Sun, 27 Apr 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jdProLFf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC014EC5B;
	Sun, 27 Apr 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745767345; cv=fail; b=BElyLVol9KgBrrKUVMMn0A2DHR1lNhKRvo6JauBkXXOZIE5+/fjbQOE9fAKAp78NRlhVUmiMy/t/keYDPYmvXeCRBMrQFenejMKxYz4pY4uS6rfroseFQk5g0nWSUcCO3mudOTRRShP9hTkTh2pc7IWmVQxJIx1q2Bykbkk7zxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745767345; c=relaxed/simple;
	bh=Fb+8wYz3SHAMQvUMRq+wdT4yYU3nPxIK2UOENyuIhHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePT9pp2xiGO6TepoeKQqLnLyYn84f0zrHjtFZ/0RvpECTCMBFeHyn+aoBWjuHQc8m2L/GIAr/2FMPA4v+W33Yn0atyg/SOHHXuo/YTKGpIeSeMMuDR8AAs3grEndOX+tl3X/1zo9GSIm0QCJp3hH3GfjtXcWNg9XXlodKv0ScA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jdProLFf; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRTt0+FtgW+B+PmbgR9abRQ3iZ9jK3u24SWcZplNofJsRWWrgsdc1nt8mHlqQKNKfdF6KQ4bklBGwX+qrcEjkNFfunlYDCy0YEpa2XlwXzOq8A/Uxhwm582nD8/Beu8O+xl2HY4RMgtPVzSLa8heZQM9A0JtSqkBXigbPD1i2FXC5lfpsLAOTpH2r7hbLqugKpC1BibA2hafuClqJKnb37Qq3PUuaX+WNL01dV5X6fcui++MrFJf2zJtUAOtrMrwtmXEY677kwQEzSWVfMPR9LBWJ+v91ds6TvfD4tJzyCUHTiGLVcamxA8CKWg434SD4SQ6prkHaoSTazEHM7cr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQIyrF7f1FXLNm3usx42uebVKbhhcefwQ4dB6/Vv6Kk=;
 b=yhdH6EgjXj93B1sPfz5k69cR1zB9qiVMojQliUVjb06fONYq5FWEd5yfon1yHm+GnrVORtZnHdYgtFlaeU0eiYmLm66WBd2VNO/kU1CNMP+c+JUEM0pIDTJoEDBIGt4HqYdCDq0Stl8n6g9eyiAlEYgWs/RdSrkKTcwWXGNMKNj7/PNXcp5Ebpc5nN/Xwp89seRJJYXBJc0nXdQLGmSf/6DuoKkrUwBaREkwemE9DrXKeyJIl1sztsixep2U4Eu09BgTUT7oQ8BecrKuSmMJRlGSiU+ZokfInokuoVeUkP3/QYg1VEICFRdCl7BpcwRNq320sk2h1OCmde3uIoSV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQIyrF7f1FXLNm3usx42uebVKbhhcefwQ4dB6/Vv6Kk=;
 b=jdProLFf2dX1+UIFfFeOxJXKmCPyKyEJ6paIMAGZSRBpwJDHfhCPNmc4W9rdhDggpi8nI4D++Y8C5m4i7/RV10yAsKsqNr8VAy93mqhPvWoYWqlic9umeXhOFt216GZ+B89keqpJltM7i+ifsYfF7FTLlEBPnjMgKS1FSrx+ezuv7htHNu3AvH+ecp77wvj5imtLE4VtypTOnlSb89XVThATtU0/SiUOznZN+5prmZm7Hd3KdtN1R4fA+DFTDwtGHFao9VOWcDyb/8tRe6BrRXwkEfzkpurnsCR9l9QnpFMN9IpqAEWP6U1Wwy+9qdUVerc/wwxty4Jh40jXredLxA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Sun, 27 Apr
 2025 15:22:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Sun, 27 Apr 2025
 15:22:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHbtgJUCHBVQ2nlJkec17kVDKNMEbO3nz/g
Date: Sun, 27 Apr 2025 15:22:20 +0000
Message-ID:
 <SN6PR02MB41574AAF7B468757A9F9ED79D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <aAu8qsMQlbgH82iN@kspp>
In-Reply-To: <aAu8qsMQlbgH82iN@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10025:EE_
x-ms-office365-filtering-correlation-id: e634b547-9963-4ffb-d7db-08dd859f4d6c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|41001999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?iZ/UVWTvyKmZtlrmyEfvCJVAhkwl91j4Kju3xSzTAd5++0bNmMNKQuLkHs?=
 =?iso-8859-2?Q?BD1jVtCFccZXlIqUADCy/SBONBE4DZOuN5JOUuuKkWKaYCkB7qYduHGteh?=
 =?iso-8859-2?Q?6YQypGdXKFUgebH8Y2vGA8mBwmlYCD+yE0enjytS4FL0yIeT3UgXrqNsHb?=
 =?iso-8859-2?Q?5aGfu6Q0QUdk+isRSWrquMIik+G+yzlbbe6Qen9SyDdPrAr1pNNpnsv/XE?=
 =?iso-8859-2?Q?ubh1EH642tcRqAIOtt87XgPzQwYxsmmBVaWj+IDe77DULKNoYm9CVqsNgk?=
 =?iso-8859-2?Q?Hhk4wGXJa7uUyHVTFZWhbyYih01d6NmkcVnZc70XKV9/FsEGxOBUdgikVT?=
 =?iso-8859-2?Q?rOIgeoSBtGa4eqNA66mc7NDNbwKmINkMVPHGNkoGt1UZF9wwy5rRnWmHXu?=
 =?iso-8859-2?Q?yJIlMfiFukmRyqDLO8ebrxubrjN55hV5WxFx1hfgyj8xQMaL3DCxJ9FnnT?=
 =?iso-8859-2?Q?GXSBKHMEhe9KIkE5XSXBw9r/iG1RWae6RO60ULwiZGvsRie/aLcEtta7Js?=
 =?iso-8859-2?Q?V5uZTKONqqc6qVzhnQgZOSSgSIIbIkjphBKoIUsNDcB9b/aknK7zroPwKq?=
 =?iso-8859-2?Q?2UA6kJSbWA8sL9zfIrtjePJwyCyzR80A+X8BGXyIDPTAIHMlEMAcVGMZ3C?=
 =?iso-8859-2?Q?hJjYrAuzOp49L/pM2WAvK8V/NV8DeAAtIE5OP/dCgSeSF3y0/okTpZm8Xx?=
 =?iso-8859-2?Q?oQi6aSfwQbB2hl36dllrKDmaDD8WkN9hs5VmxBibr0qUjq3dju+jSOCFa0?=
 =?iso-8859-2?Q?HGtNn07mmGs1T/W6RqLwYXt2gfEFaEcdVrlumwznSWFMaQclBPD4BOKV2o?=
 =?iso-8859-2?Q?gkONxDbzkncZ1z3MIYsvDUlyna1a+MDdcnuA2aAQmjifRRhXfoeMG4zBs/?=
 =?iso-8859-2?Q?I1K+gJXXJG5Ed/0vHVrfNv4MOIiqDETswb8T3Z0Xpdb3fZmOZM5SvUNUey?=
 =?iso-8859-2?Q?jxbzHr7GpEC4XXg/NtwH0p533A3LbKLZ2R8guj7dxWOjzCCxQVxt0UPzpP?=
 =?iso-8859-2?Q?nCwsZ40twFiJCr0cHjhrxUnAaGSxNMj3BzNsbalyTBT17sjMdqaDY++a7E?=
 =?iso-8859-2?Q?PAF9Qva4QLSWbSbSmWJT6qExHj/6dA91kExQnO0F0PPrFxgIfeOqa/0uT+?=
 =?iso-8859-2?Q?EZL3ogCeoCM66lAq//OCDr2LMjBkD81SUePR3Q0LxTOA7gTyb4IBC+SS7N?=
 =?iso-8859-2?Q?N/Ghni7k8BikTg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?tq7swbneV2wXWyNibjWU+DiLMXV5gDMLlLL7pj452WbGUwuXVyCnhzq8ML?=
 =?iso-8859-2?Q?FfwpXMowoaHESlXFPFhLabHPwpIV1nE3hPu6RFoHDh6h77fNjCA5opUAl1?=
 =?iso-8859-2?Q?4QnbRtN8z71FhQo7EAuV2NwDp5UPbs5Zqj3rb8Pkc9QGRSfaY2tGNIfS1s?=
 =?iso-8859-2?Q?QFn2IxlcgulhgofN9igTI2wE0AeqBgsXScDA6P8GI/b8JwuBxd95JtyOrS?=
 =?iso-8859-2?Q?l49CTq3UtvGQMk8SFjlu1jhzyS7C+HtZUTYdj89tY0Mo/VKGiV+vH8kmvJ?=
 =?iso-8859-2?Q?Hvzq06Zn/raHoRexhYQQjmhK1Euh/Qy/0k6t0POqN06VN7LG3/UBQb6EUB?=
 =?iso-8859-2?Q?knTPvXeTKef/8Op0J2ZQZUpDE+FAtXBUPBsJ1obmvG7qqSypp4J6dy4N2B?=
 =?iso-8859-2?Q?9LDz+3EuplwAeZGCwCGumOU4688QBU7MYSHtZ91Mm231SQmh0AZL2ecZy4?=
 =?iso-8859-2?Q?vAuc4g74pCyuKyoECfelpkVB55RgJvtuWmaRrVOG2UMf3oQprkjVnVHnCe?=
 =?iso-8859-2?Q?Qnvr050DxoQjkFNHRWhcR74uGlbnmvPb9F9yc5CXri/c2EvxgSsVRTGbE4?=
 =?iso-8859-2?Q?VJ+iU1vMDjenMX5ms3lNt79qzJivGyRGKp6ccOyZB+FLhOSCRxHqnFNoHr?=
 =?iso-8859-2?Q?WwBKeKF9FZkpkssP8l0QQKvuQmnCTk7UFijuO7wnhk2gsFNZr6rwz7gCDy?=
 =?iso-8859-2?Q?8KNZK8AC6nAVQmdzbbWSNCy0ve2WQFB+eESp8b3iXAZWFappVoCsqFuckC?=
 =?iso-8859-2?Q?BNW5co1HUPOPLIawdMGii082R1FBsZ1Slx5tGNYTk6qMaAKkF0Cmq9JN7h?=
 =?iso-8859-2?Q?JllYNNpArAYs46x5A4RufXG+nPLX0eAc/qMbKOkyIwpZDGBPlo4suFVsEn?=
 =?iso-8859-2?Q?9k1+4q6iOoE6modz1wE7Mc35Anz399cPY9bJiEg7hJ+h3hnrjoOH0+oNub?=
 =?iso-8859-2?Q?ModY8S7P0aMUkHFQnD551L/ctuER2Q0sCnyDw3yYDc6va7W5S4atm6dOD9?=
 =?iso-8859-2?Q?k5bkqzZPpfvMmT4RceJBFAs3LL6unx3CCaDQrLN9oofaLKJaYYdTegmQuQ?=
 =?iso-8859-2?Q?q2abMRE/WvQt9y54vggLkpJI3oeHZFKbhnGK8rmDRxXhDJ07dql4IBA7K4?=
 =?iso-8859-2?Q?JruOXEaVEu5a9akJguiRyexyoc+hai9Q9y6zZ0V7VRU/bPZZ9s7zlxWr7q?=
 =?iso-8859-2?Q?w27DSaETNxFVpDdY6qvXs4MkYUuDdfN8BUgDU4jaUKsas9BRK7QhD5ngmQ?=
 =?iso-8859-2?Q?ALSfE5FwCzegQzhjL6oU5f/CJHSgHJ64L4g+JeMZk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e634b547-9963-4ffb-d7db-08dd859f4d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 15:22:20.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025

From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, April 25, 2=
025 9:48 AM
>=20
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>=20
> Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> of a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
>=20
> So, with these changes, fix the following warnings:
>=20
> drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]
> drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure containin=
g a flexible
> array member is not at the end of another structure [-Wflex-array-member-=
not-at-end]

I'm supportive of cleaning up these warnings. I've worked with the pci-hype=
rv.c
code a fair amount over the years, but never had looked closely at the on-s=
tack
structs that are causing the warnings. The current code is a bit unusual an=
d
perhaps unnecessarily obtuse.

Rather than the approach you've taken below, I tried removing the flex arra=
y
entirely from struct pci_packet. In all cases except one, it was used only =
to
locate the end of struct pci_packet, which is the beginning of the follow-o=
n
message. Locating that follow-on message can easily be done by just referen=
cing
the "buf" field in the on-stack structs, or as (pkt + 1) in the dynamically=
 allocated
case. In both cases, there's no need for the flex array. In the one excepti=
on, a
couple of minor tweaks avoids the need for the flex array as well.

So here's an alternate approach to solving the problem. This approach is
14 insertions and 15 deletions, so it's a lot less change than your approac=
h.
I still don't understand why the on-stack struct are declared as (for examp=
le):

	struct {
		struct pci_packet pkt;
		char buf[sizeof(struct pci_read_block)];
	} pkt;

instead of just:

	struct {
		struct pci_packet pkt;
		struct pci_read_block msg;
	} pkt;

but that's a topic for another time.  Anyway, here's my proposed diff, whic=
h I've
compiled and smoke-tested in a VM in the Azure cloud:

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index e1eaa24559a2..ca5459e0dfcb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -309,8 +309,6 @@ struct pci_packet {
 	void (*completion_func)(void *context, struct pci_response *resp,
 				int resp_packet_size);
 	void *compl_ctxt;
-
-	struct pci_message message[];
 };
=20
 /*
@@ -1438,7 +1436,7 @@ static int hv_read_config_block(struct pci_dev *pdev,=
 void *buf,
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.pkt.completion_func =3D hv_pci_read_config_compl;
 	pkt.pkt.compl_ctxt =3D &comp_pkt;
-	read_blk =3D (struct pci_read_block *)&pkt.pkt.message;
+	read_blk =3D (struct pci_read_block *)pkt.buf;
 	read_blk->message_type.type =3D PCI_READ_BLOCK;
 	read_blk->wslot.slot =3D devfn_to_wslot(pdev->devfn);
 	read_blk->block_id =3D block_id;
@@ -1518,7 +1516,7 @@ static int hv_write_config_block(struct pci_dev *pdev=
, void *buf,
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.pkt.completion_func =3D hv_pci_write_config_compl;
 	pkt.pkt.compl_ctxt =3D &comp_pkt;
-	write_blk =3D (struct pci_write_block *)&pkt.pkt.message;
+	write_blk =3D (struct pci_write_block *)pkt.buf;
 	write_blk->message_type.type =3D PCI_WRITE_BLOCK;
 	write_blk->wslot.slot =3D devfn_to_wslot(pdev->devfn);
 	write_blk->block_id =3D block_id;
@@ -1599,7 +1597,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev=
,
 		return;
 	}
 	memset(&ctxt, 0, sizeof(ctxt));
-	int_pkt =3D (struct pci_delete_interrupt *)&ctxt.pkt.message;
+	int_pkt =3D (struct pci_delete_interrupt *)ctxt.buffer;
 	int_pkt->message_type.type =3D
 		PCI_DELETE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
@@ -2482,7 +2480,7 @@ static struct hv_pci_dev *new_pcichild_device(struct =
hv_pcibus_device *hbus,
 	comp_pkt.hpdev =3D hpdev;
 	pkt.init_packet.compl_ctxt =3D &comp_pkt;
 	pkt.init_packet.completion_func =3D q_resource_requirements;
-	res_req =3D (struct pci_child_message *)&pkt.init_packet.message;
+	res_req =3D (struct pci_child_message *)pkt.buffer;
 	res_req->message_type.type =3D PCI_QUERY_RESOURCE_REQUIREMENTS;
 	res_req->wslot.slot =3D desc->win_slot.slot;
=20
@@ -2860,7 +2858,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 		pci_destroy_slot(hpdev->pci_slot);
=20
 	memset(&ctxt, 0, sizeof(ctxt));
-	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
+	ejct_pkt =3D (struct pci_eject_response *)ctxt.buffer;
 	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
@@ -3118,7 +3116,7 @@ static int hv_pci_protocol_negotiation(struct hv_devi=
ce *hdev,
 	init_completion(&comp_pkt.host_event);
 	pkt->completion_func =3D hv_pci_generic_compl;
 	pkt->compl_ctxt =3D &comp_pkt;
-	version_req =3D (struct pci_version_request *)&pkt->message;
+	version_req =3D (struct pci_version_request *)(pkt + 1);
 	version_req->message_type.type =3D PCI_QUERY_PROTOCOL_VERSION;
=20
 	for (i =3D 0; i < num_version; i++) {
@@ -3340,7 +3338,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	init_completion(&comp_pkt.host_event);
 	pkt->completion_func =3D hv_pci_generic_compl;
 	pkt->compl_ctxt =3D &comp_pkt;
-	d0_entry =3D (struct pci_bus_d0_entry *)&pkt->message;
+	d0_entry =3D (struct pci_bus_d0_entry *)(pkt + 1);
 	d0_entry->message_type.type =3D PCI_BUS_D0ENTRY;
 	d0_entry->mmio_base =3D hbus->mem_config->start;
=20
@@ -3498,20 +3496,20 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
=20
 		if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2) {
 			res_assigned =3D
-				(struct pci_resources_assigned *)&pkt->message;
+				(struct pci_resources_assigned *)(pkt + 1);
 			res_assigned->message_type.type =3D
 				PCI_RESOURCES_ASSIGNED;
 			res_assigned->wslot.slot =3D hpdev->desc.win_slot.slot;
 		} else {
 			res_assigned2 =3D
-				(struct pci_resources_assigned2 *)&pkt->message;
+				(struct pci_resources_assigned2 *)(pkt + 1);
 			res_assigned2->message_type.type =3D
 				PCI_RESOURCES_ASSIGNED2;
 			res_assigned2->wslot.slot =3D hpdev->desc.win_slot.slot;
 		}
 		put_pcichild(hpdev);
=20
-		ret =3D vmbus_sendpacket(hdev->channel, &pkt->message,
+		ret =3D vmbus_sendpacket(hdev->channel, pkt + 1,
 				size_res, (unsigned long)pkt,
 				VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -3809,6 +3807,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bo=
ol keep_devs)
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
 	} pkt;
+	struct pci_message *msg;
 	struct hv_pci_compl comp_pkt;
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
@@ -3854,10 +3853,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool keep_devs)
 	init_completion(&comp_pkt.host_event);
 	pkt.teardown_packet.completion_func =3D hv_pci_generic_compl;
 	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
-	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
+	msg =3D (struct pci_message *)pkt.buffer;
+	msg->type =3D PCI_BUS_D0EXIT;
=20
-	ret =3D vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
-				     sizeof(struct pci_message),
+	ret =3D vmbus_sendpacket_getid(chan, msg, sizeof(*msg),
 				     (unsigned long)&pkt.teardown_packet,
 				     &trans_id, VM_PKT_DATA_INBAND,
 				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
Let me know what you think.

Michael

>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 126 ++++++++++++----------------
>  1 file changed, 55 insertions(+), 71 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e1eaa24559a2..f2b5036bcf64 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1420,10 +1420,8 @@ static int hv_read_config_block(struct pci_dev *pd=
ev, void
> *buf,
>  	struct hv_pcibus_device *hbus =3D
>  		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
>  			     sysdata);
> -	struct {
> -		struct pci_packet pkt;
> -		char buf[sizeof(struct pci_read_block)];
> -	} pkt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
> +			sizeof(struct pci_read_block));
>  	struct hv_read_config_compl comp_pkt;
>  	struct pci_read_block *read_blk;
>  	int ret;
> @@ -1435,17 +1433,16 @@ static int hv_read_config_block(struct pci_dev *p=
dev, void
> *buf,
>  	comp_pkt.buf =3D buf;
>  	comp_pkt.len =3D len;
>=20
> -	memset(&pkt, 0, sizeof(pkt));
> -	pkt.pkt.completion_func =3D hv_pci_read_config_compl;
> -	pkt.pkt.compl_ctxt =3D &comp_pkt;
> -	read_blk =3D (struct pci_read_block *)&pkt.pkt.message;
> +	pkt->completion_func =3D hv_pci_read_config_compl;
> +	pkt->compl_ctxt =3D &comp_pkt;
> +	read_blk =3D (struct pci_read_block *)pkt->message;
>  	read_blk->message_type.type =3D PCI_READ_BLOCK;
>  	read_blk->wslot.slot =3D devfn_to_wslot(pdev->devfn);
>  	read_blk->block_id =3D block_id;
>  	read_blk->bytes_requested =3D len;
>=20
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, read_blk,
> -			       sizeof(*read_blk), (unsigned long)&pkt.pkt,
> +			       sizeof(*read_blk), (unsigned long)pkt,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> @@ -1500,11 +1497,8 @@ static int hv_write_config_block(struct pci_dev *p=
dev, void
> *buf,
>  	struct hv_pcibus_device *hbus =3D
>  		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
>  			     sysdata);
> -	struct {
> -		struct pci_packet pkt;
> -		char buf[sizeof(struct pci_write_block)];
> -		u32 reserved;
> -	} pkt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
> +			sizeof(struct pci_write_block) + sizeof(u32));
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_write_block *write_blk;
>  	u32 pkt_size;
> @@ -1515,10 +1509,9 @@ static int hv_write_config_block(struct pci_dev *p=
dev, void
> *buf,
>=20
>  	init_completion(&comp_pkt.host_event);
>=20
> -	memset(&pkt, 0, sizeof(pkt));
> -	pkt.pkt.completion_func =3D hv_pci_write_config_compl;
> -	pkt.pkt.compl_ctxt =3D &comp_pkt;
> -	write_blk =3D (struct pci_write_block *)&pkt.pkt.message;
> +	pkt->completion_func =3D hv_pci_write_config_compl;
> +	pkt->compl_ctxt =3D &comp_pkt;
> +	write_blk =3D (struct pci_write_block *)pkt->message;
>  	write_blk->message_type.type =3D PCI_WRITE_BLOCK;
>  	write_blk->wslot.slot =3D devfn_to_wslot(pdev->devfn);
>  	write_blk->block_id =3D block_id;
> @@ -1532,10 +1525,10 @@ static int hv_write_config_block(struct pci_dev *=
pdev,
> void *buf,
>  	 * and new hosts, because, on them, what really matters is the length
>  	 * specified in write_blk->byte_count.
>  	 */
> -	pkt_size +=3D sizeof(pkt.reserved);
> +	pkt_size +=3D sizeof(u32);
>=20
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, write_blk, pkt_size,
> -			       (unsigned long)&pkt.pkt, VM_PKT_DATA_INBAND,
> +			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
>  		return ret;
> @@ -1589,17 +1582,14 @@ static void hv_int_desc_free(struct hv_pci_dev *h=
pdev,
>  			     struct tran_int_desc *int_desc)
>  {
>  	struct pci_delete_interrupt *int_pkt;
> -	struct {
> -		struct pci_packet pkt;
> -		u8 buffer[sizeof(struct pci_delete_interrupt)];
> -	} ctxt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
> +			sizeof(struct pci_delete_interrupt));
>=20
>  	if (!int_desc->vector_count) {
>  		kfree(int_desc);
>  		return;
>  	}
> -	memset(&ctxt, 0, sizeof(ctxt));
> -	int_pkt =3D (struct pci_delete_interrupt *)&ctxt.pkt.message;
> +	int_pkt =3D (struct pci_delete_interrupt *)pkt->message;
>  	int_pkt->message_type.type =3D
>  		PCI_DELETE_INTERRUPT_MESSAGE;
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
> @@ -1798,6 +1788,12 @@ static u32 hv_compose_msi_req_v3(
>  	return sizeof(*int_pkt);
>  }
>=20
> +union int_pkts {
> +	struct pci_create_interrupt v1;
> +	struct pci_create_interrupt2 v2;
> +	struct pci_create_interrupt3 v3;
> +};
> +
>  /**
>   * hv_compose_msi_msg() - Supplies a valid MSI address/data
>   * @data:	Everything about this MSI
> @@ -1811,6 +1807,13 @@ static u32 hv_compose_msi_req_v3(
>   */
>  static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *ms=
g)
>  {
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message, sizeof(union int_pkts)=
);
> +	struct pci_create_interrupt *pkt_v1 =3D
> +				(struct pci_create_interrupt *)pkt->message;
> +	struct pci_create_interrupt2 *pkt_v2 =3D
> +				(struct pci_create_interrupt2 *)pkt->message;
> +	struct pci_create_interrupt3 *pkt_v3 =3D
> +				(struct pci_create_interrupt3 *)pkt->message;
>  	struct hv_pcibus_device *hbus;
>  	struct vmbus_channel *channel;
>  	struct hv_pci_dev *hpdev;
> @@ -1826,14 +1829,6 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta,
> struct msi_msg *msg)
>  	 */
>  	u16 vector_count;
>  	u32 vector;
> -	struct {
> -		struct pci_packet pci_pkt;
> -		union {
> -			struct pci_create_interrupt v1;
> -			struct pci_create_interrupt2 v2;
> -			struct pci_create_interrupt3 v3;
> -		} int_pkts;
> -	} __packed ctxt;
>  	bool multi_msi;
>  	u64 trans_id;
>  	u32 size;
> @@ -1910,14 +1905,13 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  	 * can't exceed u8. Cast 'vector' down to u8 for v1/v2 explicitly
>  	 * for better readability.
>  	 */
> -	memset(&ctxt, 0, sizeof(ctxt));
>  	init_completion(&comp.comp_pkt.host_event);
> -	ctxt.pci_pkt.completion_func =3D hv_pci_compose_compl;
> -	ctxt.pci_pkt.compl_ctxt =3D &comp;
> +	pkt->completion_func =3D hv_pci_compose_compl;
> +	pkt->compl_ctxt =3D &comp;
>=20
>  	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
> -		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> +		size =3D hv_compose_msi_req_v1(pkt_v1,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
>  					vector_count);
> @@ -1925,7 +1919,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>=20
>  	case PCI_PROTOCOL_VERSION_1_2:
>  	case PCI_PROTOCOL_VERSION_1_3:
> -		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> +		size =3D hv_compose_msi_req_v2(pkt_v2,
>  					cpu,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
> @@ -1933,7 +1927,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  		break;
>=20
>  	case PCI_PROTOCOL_VERSION_1_4:
> -		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> +		size =3D hv_compose_msi_req_v3(pkt_v3,
>  					cpu,
>  					hpdev->desc.win_slot.slot,
>  					vector,
> @@ -1950,8 +1944,8 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  		goto free_int_desc;
>  	}
>=20
> -	ret =3D vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, &ctxt.int_pk=
ts,
> -				     size, (unsigned long)&ctxt.pci_pkt,
> +	ret =3D vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, pkt->message=
,
> +				     size, (unsigned long)pkt,
>  				     &trans_id, VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
> @@ -2034,7 +2028,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  	 *
>  	 * Cf. hv_pci_onchannelcallback().
>  	 */
> -	vmbus_request_addr_match(channel, trans_id, (unsigned long)&ctxt.pci_pk=
t);
> +	vmbus_request_addr_match(channel, trans_id, (unsigned long)pkt);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2464,10 +2458,8 @@ static struct hv_pci_dev *new_pcichild_device(stru=
ct
> hv_pcibus_device *hbus,
>  	struct hv_pci_dev *hpdev;
>  	struct pci_child_message *res_req;
>  	struct q_res_req_compl comp_pkt;
> -	struct {
> -		struct pci_packet init_packet;
> -		u8 buffer[sizeof(struct pci_child_message)];
> -	} pkt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
> +			sizeof(struct pci_child_message));
>  	unsigned long flags;
>  	int ret;
>=20
> @@ -2477,18 +2469,17 @@ static struct hv_pci_dev *new_pcichild_device(str=
uct
> hv_pcibus_device *hbus,
>=20
>  	hpdev->hbus =3D hbus;
>=20
> -	memset(&pkt, 0, sizeof(pkt));
>  	init_completion(&comp_pkt.host_event);
>  	comp_pkt.hpdev =3D hpdev;
> -	pkt.init_packet.compl_ctxt =3D &comp_pkt;
> -	pkt.init_packet.completion_func =3D q_resource_requirements;
> -	res_req =3D (struct pci_child_message *)&pkt.init_packet.message;
> +	pkt->compl_ctxt =3D &comp_pkt;
> +	pkt->completion_func =3D q_resource_requirements;
> +	res_req =3D (struct pci_child_message *)pkt->message;
>  	res_req->message_type.type =3D PCI_QUERY_RESOURCE_REQUIREMENTS;
>  	res_req->wslot.slot =3D desc->win_slot.slot;
>=20
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, res_req,
> -			       sizeof(struct pci_child_message),
> -			       (unsigned long)&pkt.init_packet,
> +			       __member_size(pkt->message),
> +			       (unsigned long)pkt,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> @@ -2827,10 +2818,8 @@ static void hv_eject_device_work(struct work_struc=
t
> *work)
>  	struct pci_dev *pdev;
>  	unsigned long flags;
>  	int wslot;
> -	struct {
> -		struct pci_packet pkt;
> -		u8 buffer[sizeof(struct pci_eject_response)];
> -	} ctxt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
> +			sizeof(struct pci_eject_response));
>=20
>  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
>  	hbus =3D hpdev->hbus;
> @@ -2859,8 +2848,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	if (hpdev->pci_slot)
>  		pci_destroy_slot(hpdev->pci_slot);
>=20
> -	memset(&ctxt, 0, sizeof(ctxt));
> -	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
> +	ejct_pkt =3D (struct pci_eject_response *)pkt->message;
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> @@ -3805,10 +3793,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev,=
 bool
> keep_devs)
>  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
>  	struct vmbus_channel *chan =3D hdev->channel;
> -	struct {
> -		struct pci_packet teardown_packet;
> -		u8 buffer[sizeof(struct pci_message)];
> -	} pkt;
> +	DEFINE_RAW_FLEX(struct pci_packet, pkt, message, 1);
>  	struct hv_pci_compl comp_pkt;
>  	struct hv_pci_dev *hpdev, *tmp;
>  	unsigned long flags;
> @@ -3850,15 +3835,14 @@ static int hv_pci_bus_exit(struct hv_device *hdev=
, bool
> keep_devs)
>  		return ret;
>  	}
>=20
> -	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
>  	init_completion(&comp_pkt.host_event);
> -	pkt.teardown_packet.completion_func =3D hv_pci_generic_compl;
> -	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
> -	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
> +	pkt->completion_func =3D hv_pci_generic_compl;
> +	pkt->compl_ctxt =3D &comp_pkt;
> +	pkt->message[0].type =3D PCI_BUS_D0EXIT;
>=20
> -	ret =3D vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
> -				     sizeof(struct pci_message),
> -				     (unsigned long)&pkt.teardown_packet,
> +	ret =3D vmbus_sendpacket_getid(chan, pkt->message,
> +				     __member_size(pkt->message),
> +				     (unsigned long)pkt,
>  				     &trans_id, VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> @@ -3873,7 +3857,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> keep_devs)
>  		 * Cf. hv_pci_onchannelcallback().
>  		 */
>  		vmbus_request_addr_match(chan, trans_id,
> -					 (unsigned long)&pkt.teardown_packet);
> +					 (unsigned long)pkt);
>  		return -ETIMEDOUT;
>  	}
>=20
> --
> 2.43.0
>=20


