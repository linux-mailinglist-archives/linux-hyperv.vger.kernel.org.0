Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC273E1AF0
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhHESHx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:07:53 -0400
Received: from mail-dm6nam10on2124.outbound.protection.outlook.com ([40.107.93.124]:29664
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239814AbhHESHw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+/EryuyVvKDbqJ0b85u88sc2zonJt/LPu9l/bBrcIlaYbjtdEJE6Zy27kY2oRSUxSmwT2eEUE7NW7e6skw81An277W2IcOcIaaWVXl6LwsjUmJo1qDqqXGb69sQhd0/vA9W2janqJUa4CpVpP9OqKi7J0kyqNwwqPGsWKw3vi+WuXO22+BlhPVzAiQhdnuqAQF4t3KzPCAS1X+AUwLdtcCScP4+JH430EQku6gPM74ESyq53WNmbzP0k8Fwln/2Aaf0LTU3+BX9/iW2fVN0KG+hhjbAhYhseOEQa5eKTNnlrDE+qy5bIft5RdNTOYdgROkskrM9N0M+zY6LbXOmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h44Z0nsoHaWcMrPX54v/MFqNe2OJxDE/6umankCo1Q=;
 b=R+ld+EIiI3TgGJNsUYR0LhE+xDJQ8mXowHDDIvgxHbSvVpbmj2f0LZ9FAkYTBl3p1Y6zO7iDbXjznnDICRnr60tDdMs4MIYVbosJlbbVYJosomHsHwt0+mDHBI4Pl3j6CFg5w//rUoLSENfLQLWEDZ5bqX+jSSszdfhkA8DEzwYdK9nU7DfUdl+AzxyXP7la91+jpEWr3x2NVvzqEBwIDPG0PvQVWN03f4m6NyTa7cGYbx1XVwEankYmn+3Tr/qxbVa+AA8ulvcXnHS4feAVjE7QbGTwYpsO+PUUNaoQ+ouaaEQ1FHMeOuBLTsIZdQvjNx+V/HeaM7BcgWj60P/H0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h44Z0nsoHaWcMrPX54v/MFqNe2OJxDE/6umankCo1Q=;
 b=N45jDmt673LEe+YNxE+z+mmD0QkQe0K7KAOBoBb1h6shC69qWikz5vK05Hv8mUz39VvHRMR/nggEHzuGOinQNhhK5BMh0xblhaRPe4cIEe7kDojXkRfNIwAlezsJJ0jLODPea5TzBeCqvBAP/d1wionYg4odXlIbR2AxETNnEwo=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB2023.namprd21.prod.outlook.com (2603:10b6:a03:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Thu, 5 Aug
 2021 18:07:31 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 18:07:31 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXicedDOclmRZNxku+6+eTWPWUTatkfq6AgAC1IUA=
Date:   Thu, 5 Aug 2021 18:07:31 +0000
Message-ID: <BY5PR21MB15061507ED1B0CE1CDC7EE3ECEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
 <YQuPJUX4+HZ3FeKC@kroah.com>
In-Reply-To: <YQuPJUX4+HZ3FeKC@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=430b51c1-9820-4c03-b1f1-5f6b69cfface;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T17:59:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1666456d-0b3d-453d-ff1f-08d9583be50a
x-ms-traffictypediagnostic: SJ0PR21MB2023:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB202381EDB17B754785E3A37ACEF29@SJ0PR21MB2023.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH/ubHuXb9heC6gGK1tcipKyywDpZSUTjRDS3gRwN3gLfoHO6KWi4wsVxCR/ZqY3xlCfpKNqskqRst/PyA3e+61oq+dmMLSCiRvJf8B0AV3YS6iM+DCCxlBD+RNIqLhb0YQuquS8w6dC64wr2ZivAhpXsukqZtCWkSt3RylvM8Eq1aKTFJqqdKrwFKZqfGTYr2t/HubN3k6UIkAN28Yk5yP9XbPKVprD6TGkDcGqYdX+oaD3RKlRqzI+FJNu8wK0vCP8KdmWY4FGJE8Io/cwwoRzwH8ZHC6BEsGfrJxSzP6V3bnK4fkC/pcfYTZ55Bo12OHE5xm5ExB6Cto7or+Nqx3HCuVT/nohMjSXxo7tVxvZVL3/qW82e4geJ3DOn6XbBLfA06KHqUuObNZGHmznismpgJvSwhLN6cz9cqLO7Hr+8BwlhGtCrQUAKj2KeRwvcsu83OTiQthjamrKNiKb0ZYOWUpkuUKPb3Si446SnSPYKTtZcl+awFir5Y6eHykr26bQeyMSXbekaxW3wGP37l5i8jC7ph3FkldGHMrMYlIfHk2c+AsdAMgBvrMDqxhSF/1khonTdA7DZ2mlrKekm4U2Aiyhh3UwwTbgr7ADKrDOMtQV1QblF/n5U10ENiEwZmrHTF98UFc8KOtNTuT1+npM5FAgYQkCLjKNdec3M9ERR5XdBwmCJprvjyiop88QG7YGawp1BbQLdXcM6uItwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(9686003)(66946007)(82960400001)(54906003)(38100700002)(66476007)(64756008)(82950400001)(66446008)(8936002)(83380400001)(55016002)(110136005)(5660300002)(508600001)(7696005)(122000001)(71200400001)(26005)(316002)(6506007)(10290500003)(4744005)(186003)(4326008)(8990500004)(86362001)(52536014)(38070700005)(76116006)(2906002)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YMOHX0laY6ca5aTLYT07i6qYbVtaezVQNBLo3SdKTB4CcOzLrylIosBv9LPw?=
 =?us-ascii?Q?QWBLJyn8OBtDDWMwGH9PN7NgKpDRsfHyf0A/QGLLrioI4ui8J/Q4mbB/qL5b?=
 =?us-ascii?Q?EO06uOK8Dw/pAkMx11c2ATtY64nrcPBQ6t52qZ+eV/a/WqwqPdegTkLcjsc2?=
 =?us-ascii?Q?1ahija+PkfrjEW769PdLDLhjlws2TyAwXaytXBHmGs608Av/targ0watPNCN?=
 =?us-ascii?Q?I4irCjsz2FGc5YbCdbzOzz9r5U9oSSYLf+IzqN8zsQyTEDbYbCg7iv2LxWrW?=
 =?us-ascii?Q?qMXf1A48wwGcUVTZsg0v2sGnbyJ5Gn/PBiLJhjU8TfMIwasqnvcaYlrTJMsX?=
 =?us-ascii?Q?8VVEMjgOE3ZRF7AA8mR8f3ovk4X4q8gWTvMnykcyrcRRY714joiTv8OixqrV?=
 =?us-ascii?Q?TvOr49hKnV7R9FiuX2qymSQQIpjM30uFswav4fU6UIDrZYfV2dAAWA2u9COz?=
 =?us-ascii?Q?ZUm3J9ODNOtz/85uFt9ky8lG9rdXKaoPtZpDF1hxhoe9y7h1T08h7sfzO3yg?=
 =?us-ascii?Q?3A9qgYtmdL8k63Ne4+Omvyt/qs9+ajpmwd7tP1Hfp7j3LOg3X//8uCEQtpB9?=
 =?us-ascii?Q?OF9+bytdH8RzXqsYkAifqTi/msb8lYdD1y9r7M2UXuYbP/PUVGkjXJQiDOL+?=
 =?us-ascii?Q?JajLAdn7QoaBU6Kh5sunYHFVsdqrQ7vzaVmxCNySKyMu9+7p9/hcdohTWzFe?=
 =?us-ascii?Q?cH04a4mqAT250EtIaKzjbllt9Rb6pPKPKRgrjbuY9nbx5JfWsiPn4OcmkAJp?=
 =?us-ascii?Q?aYq3t+X8+jHn9N4dCEfwvf44pFGq5H8pdAOdSHpKyNaXWeqmu236jpw1ZrpW?=
 =?us-ascii?Q?b/QhGx0cntnVkeoSH/oZSfjT7y/YRyKx7fhyeov3NM1/5LHXDfBSo0A3Hbtq?=
 =?us-ascii?Q?STYbaezHlKtpDDvPLspOQAfNuJveGPHm/rgQ9l3GkM7jiAQJSdh+swj2J+xb?=
 =?us-ascii?Q?bkOZCD2taq2fWjth/WHZnb8hjAnE2AscSyuGvdFE/EfuygtPuuUF6fLszI71?=
 =?us-ascii?Q?OzAIECXjldeJIyQ1d7Bp5gLEvcVqiXyMJMOA2W4+bPeGbdipGLHbY+svxBmo?=
 =?us-ascii?Q?rJguEn2srpk34Tmo9jAnJHFxnGf25HyzrbvS2WzT3ubj1K15wdXQXdNjTvA7?=
 =?us-ascii?Q?jBL+X7FNfmk04NZKQcjTiURKGRVeMRd8Vv0sv0DYFVHR5AbmSjQgjNUtF7oW?=
 =?us-ascii?Q?WFk8A55aWlAElyWm/7pwP/9wMjtWIjZOItA0o/uI7X9yCNsJbmPdj+Ina76c?=
 =?us-ascii?Q?r05lS9Qt6vmk/Je+ox7ubSx+Ztf/O9lWO3neZgu+18Tm8OQYGzO+3Unb4OE8?=
 =?us-ascii?Q?0HM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1666456d-0b3d-453d-ff1f-08d9583be50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 18:07:31.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG2bdTlUrvskyg+rg+tCHYi4CNtU6/BwBl8kdcssByiOY44sre9RO58UuWcPA3GnQrSCJWyUGeU9vk9RZIHPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2023
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Thu, Aug 05, 2021 at 12:00:11AM -0700, longli@linuxonhyperv.com wrote:
> > +static int az_blob_create_device(struct az_blob_device *dev) {
> > +	int ret;
> > +	struct dentry *debugfs_root;
> > +
> > +	dev->misc.minor	=3D MISC_DYNAMIC_MINOR,
> > +	dev->misc.name	=3D "azure_blob",
> > +	dev->misc.fops	=3D &az_blob_client_fops,
> > +
> > +	ret =3D misc_register(&dev->misc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	debugfs_root =3D debugfs_create_dir("az_blob", NULL);
>=20
> So you try to create a directory in the root of debugfs called "az_blob"
> for every device in the system of this one type?
>=20
> That will blow up when you have multiple devices of the same type, please
> fix.

The Hyper-V presents one such device for the whole VM.

I'm sorry I may have misunderstood. Are you suggesting I should create a di=
rectory "hyperv" in the root of debugfs and put all the Hyper-V driver debu=
g information there?

>=20
> thanks,
>=20
> greg k-h
