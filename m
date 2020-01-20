Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2D143181
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATSeF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 13:34:05 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:39265
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgATSeF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 13:34:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyAt2IrrqKT5i8Q9DLvnC+x2HxCYy2Rxd6ltIW/W6fAr7eJBgw6y4ujVkOlY/F+7OHuldsQgPzPwpZJtgfeqZiCnKXDfoB+jnkFnXn2EAKR9ceK42fpQVEXiCWTJEvW1V+3oPjyBjIzf6CfDYVKYC+qGL56gkZ8caAQB3nOJeulnc2S1g+YaV7HNK+p25XFBsBaWLkWgENnIszWXwMjxLi8FsgBbzBqauyBQ0Pt9Ltt+fd6mJSC+HJf5E7tLCOyOHjKDSdDqFb4slJ8JPFXTlzwwNxXhCbxnNkNe1AKYwzvONz7hOvQLO7SIJDTMVgo+4rZIcp0uvt9B3PcL3gNHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhHLWaPXPDXMVi9aN425whSPWOmcTxEZnnX2H+wvum4=;
 b=Qo8lXRQ/HsW5JP8LNPcJJxrOL8yVfMpsg7gZ1ShqGX4V5b0ja/wZKkXs23GrPTYlCwX7xSBi/5oMgdKSUp75okB2jY5FPwgUH5GjwD73b6n0UzZEFvlnQw+4V3ECi2ZEvyO0FwfKosOF9zSWwcpvMKBB7SDDC2qp6CvO4JJxtmRc4tPo85zWkgH9lotgK8ypJ8qdnTI3XOeQiXBGS5BKjljGoOrR8MVLcEKnZSEVSuvblWr9srxIiBAldrfPWub7mvTndk3YKyhJygk+1sjznGqob0K/NtvE5YCOLTYz8wvV7Em/8CMQPQ/k7kGPoUJQaqn2Hxyb+WuUO25cb2kYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhHLWaPXPDXMVi9aN425whSPWOmcTxEZnnX2H+wvum4=;
 b=LoRXBMweoVhuo1Qs05rSBDAWcy4CUftmE042NTS2CJO4EaRcZ2zh5A2K+an7zr0l46V/7mghBgb8Kda6uZNQ/DXZLRLumfJuDaS2rE3jPvDJ1bJtuVLQIRyiZcE0oSfde9mPPseEwfNDkKYrgK54ZDaxfEma/ZQfdkmmef67qfA=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0940.namprd21.prod.outlook.com (52.132.146.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Mon, 20 Jan 2020 18:34:01 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Mon, 20 Jan 2020
 18:34:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "namit@vmware.com" <namit@vmware.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: RE: [RFC PATCH V2 1/10] mm/resource: Move child to new resource when
 release mem region.
Thread-Topic: [RFC PATCH V2 1/10] mm/resource: Move child to new resource when
 release mem region.
Thread-Index: AQHVxVvKIEcG+CpTJkitsskMuv0x06fz8zSA
Date:   Mon, 20 Jan 2020 18:34:00 +0000
Message-ID: <MW2PR2101MB1052322016F0B5CF91AFD3B1D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200107130950.2983-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-20T18:33:58.8724560Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8500966-b3db-4344-8270-1a70d94c770c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8d6a88e-ec8e-435b-e12e-08d79dd751b2
x-ms-traffictypediagnostic: MW2PR2101MB0940:|MW2PR2101MB0940:|MW2PR2101MB0940:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09405D0CF06114401E9A6EA2D7320@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(316002)(4326008)(8990500004)(7696005)(6506007)(26005)(478600001)(71200400001)(10290500003)(8936002)(7416002)(186003)(54906003)(110136005)(2906002)(55016002)(86362001)(81156014)(81166006)(8676002)(9686003)(66446008)(52536014)(5660300002)(64756008)(66476007)(66556008)(33656002)(76116006)(66946007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +c0gUz4nZC4KjzuHTtNaCq9fVt5QBFzqNJZG8I96THCNYkBPAydGm2exQJU+TTz4mwG2Zly2vyLt8qfowxP4C+Ay87iO43i8i6nC3kO36AwDuDqRzip+xHeJacarE5FRA4LGsuVIuz1qNmsH8a+FAjm03oALAjcUA1veH4mu4nL4OsS2yTLqHKTeU7nZ+k24HpwwUQfaUn/pvBGPmT8GVdLKlQh4ZySvXfJMjMjf/zAl3C9zucOSKC5x5ghEnRHEWa5VcbTnJ5crtRMOpA5dbMNO6JMyjt4iMfi0icCalUYt6xY90aTVzVQ4sNOodCX2I81rRaqMWkiH3M3PNj5UHC9DYWfcnyJAvDEANlCP343uoDafJgPdBB0+vy55nq38VpVAOER4grHmwatjIYTOmnXgBuXEzBB5gn1POOA2DIfc5+1KcsJjY358E2Vg2ZH8MzHakrkaqj+T2/zCAgWnb25aGSSNGRxl98+ZJDEpIjeFb1WSS5fwkXxamUejgbIn
x-ms-exchange-antispam-messagedata: HLZsGufKc8QWGB9oy1VWaoDduf3iN72UKpwjpoGGdUO76XwJCyxXe8j2tjGxBn+MJYOLXm1liFFCvRuQkWqS4C28ysv4jSEBSA4c2gFqczpQheCLeXIU21EbK4CUbwLBcdbz6vXISMcMv8LCLd3OWQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6a88e-ec8e-435b-e12e-08d79dd751b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 18:34:00.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeZXdiE5DccVttGWtDGIs5qVsQxE861TqqJBff7MXiz0J2O0bmz0lxGXAwQ/q5RXNuYw3MVy0Vc/DA+cazJoFB0nb4FmsEklrlOJn8IWcVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, January 7, 2020 =
5:10 AM
>=20
> When release mem region, old mem region may be splited to
> two regions. Current allocate new struct resource for high
> end mem region but not move child resources whose ranges are
> in the high end range to new resource. When adjust old mem
> region's range, adjust_resource() detects child region's range
> is out of new range and return error. Move child resources to
> high end resource before adjusting old mem range.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  kernel/resource.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 76036a41143b..1c7362825134 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -181,6 +181,38 @@ static struct resource *alloc_resource(gfp_t flags)
>  	return res;
>  }
>=20
> +static void move_child_to_newresource(struct resource *old,
> +				      struct resource *new)
> +{
> +	struct resource *tmp, **p, **np;
> +
> +	if (!old->child)
> +		return;

I don't think the above test is needed.  This case is handled by the first
three lines of the "for" loop.

> +
> +	p =3D &old->child;
> +	np =3D &new->child;
> +
> +	for (;;) {
> +		tmp =3D *p;
> +		if (!tmp)
> +			break;
> +
> +		if (tmp->start >=3D new->start && tmp->end <=3D new->end) {
> +			tmp->parent =3D new;
> +			*np =3D tmp;
> +			np =3D &tmp->sibling;
> +			*p =3D tmp->sibling;
> +
> +			if (!tmp->sibling)
> +				*np =3D NULL;

I don't think the above two lines are right.  They seem tautological.  If t=
he ! were
removed it would be clearing the sibling link for the child as it exists un=
der its new
parent, which should be done.  But the child that is moved to the new paren=
t always
becomes the last entry in the new parent's child list.  So could you just u=
nconditionally
do tmp->sibling =3D NULL?   That link will get fixed up if another child is=
 moved.

Michael

> +			continue;
> +		}
> +
> +		p =3D &tmp->sibling;
> +	}
> +}
> +
> +
>  /* Return the conflict entry if you can't request it */
>  static struct resource * __request_resource(struct resource *root, struc=
t resource *new)
>  {
> @@ -1246,9 +1278,6 @@ EXPORT_SYMBOL(__release_region);
>   * Note:
>   * - Additional release conditions, such as overlapping region, can be
>   *   supported after they are confirmed as valid cases.
> - * - When a busy memory resource gets split into two entries, the code
> - *   assumes that all children remain in the lower address entry for
> - *   simplicity.  Enhance this logic when necessary.
>   */
>  int release_mem_region_adjustable(struct resource *parent,
>  				  resource_size_t start, resource_size_t size)
> @@ -1331,11 +1360,12 @@ int release_mem_region_adjustable(struct resource=
 *parent,
>  			new_res->sibling =3D res->sibling;
>  			new_res->child =3D NULL;
>=20
> +			move_child_to_newresource(res, new_res);
> +			res->sibling =3D new_res;
>  			ret =3D __adjust_resource(res, res->start,
>  						start - res->start);
>  			if (ret)
>  				break;
> -			res->sibling =3D new_res;
>  			new_res =3D NULL;
>  		}
>=20
> --
> 2.14.5

