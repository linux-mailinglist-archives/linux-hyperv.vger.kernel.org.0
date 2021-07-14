Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7D3C93A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhGNWQ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 18:16:26 -0400
Received: from mail-bn8nam08on2094.outbound.protection.outlook.com ([40.107.100.94]:28449
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236514AbhGNWQZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 18:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFzKY2n0TwH33g0NPJgjQGjXQgl4Kj9O85htZ6f9IEEk41wsfaw5d5D37GWdcfFV1xKT00tH0oT03TycwIHxwAfuiQ8duqiVq0Qw7eNYKrn+v0QcW7vN1BF+gWLO2f1okqVLfBHBrNEre7EsT8jyzqE/y6sVItXKuobRy6NqYSRhI5AGUdXf+0WlLfhx4OylI1CMNy+RUio7Cno7/Mq2HLQIviKFBqm8dQ5jz3YkWVlOi+hwUpief3DW8cu4Z/ijzB4BfqmtmteamZFh9Gz/t3X64h3WO5IgUHgdgno8CWEgXD9rqLJqvnLC8nuDGZHJXs2r+cv5If1cHYd/mF3YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHClyMop9d0EDwBLVTAUjf2/biP0SHY6QCPDQKiCNi4=;
 b=YHP/gz86KJ3P5JjKiA/CtSakhaqQAaThz6Ek2/1CKfrM3pAuc+uVGWKnu4VCfGnoyetPI1XFOMm/57eUmkMRbbnmrogjEF6oPt2ecR7gXnP0vRnMzLeOXMYQ1iQRgKPp4yGel4U5Ungu3impuNfaXn7nIffXnud/m5a+OapnG+NLaX1LKmkmD1tNrf6jzvnXzc6GLFqeGB0Ku8XXfzJxGFckvwtYvML99YmUOMeGfY+Jbq6BaskaQsluUXhAdCQAh+Wbl/+oBvYh0+EzrbkJn+2xLhJSIZ2eEWni5uN6/eg3VxXx9hdz+Yvq4dlqwSNwzJhCq4kxC3Pb1hrW9nUUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHClyMop9d0EDwBLVTAUjf2/biP0SHY6QCPDQKiCNi4=;
 b=AqYf47IU/AhLnlUm6oFMDIgK2c87GIcOmfB8+d+yXesK8/34kAu3avFYKjJzBxDf6OgY70M3x1BvtMzueM7632qA1Bmr/pOIqXHLP7Qy0xAmCxBQLFV7FoaQobcOcY7J9U2fmusD+InhGWIeq6wRzKjMRUL/xqmc3Q0AK6vBHRY=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1175.namprd21.prod.outlook.com (2603:10b6:a03:103::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Wed, 14 Jul
 2021 22:13:29 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.009; Wed, 14 Jul 2021
 22:13:29 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtCuicAgABP9iA=
Date:   Wed, 14 Jul 2021 22:13:29 +0000
Message-ID: <BY5PR21MB1506B6D88AD8939BDE47F759CE139@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <YO8eWsvgA5j3PLhd@kroah.com>
In-Reply-To: <YO8eWsvgA5j3PLhd@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88712879-37c4-49bd-a3c8-12ebe5b21c4c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-14T22:13:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75f7447-2c0a-4f38-6216-08d947149c2e
x-ms-traffictypediagnostic: BYAPR21MB1175:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB117589A592E3930FD4B4A945CE139@BYAPR21MB1175.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ygcd2OtDX0W20wywQTnUhoH8IkmRZaK5+Lt/3pHRO2HaP6EF6pfTQ4BQV1SrGOOGJ5AtFSlfnBxpEk2dJ+Usa3FE7JsGCOHCEjJkcYiVH42zFjR+T3k/jW0HhAgIucwAHTK5GILpsiCwedS9e2Mmi5MkkpkbTsW+YKvCHDFZa5OmSzQwg1ncPVHmuQOXWKKYDd0JEcoYhQPJZfRoZt9VzB5I2+qoBsGNGCa5zgm/nLU8DchaN5Cny48Zkw43BEstWliHKNccw1Eejj0PG55AErwYg0S4SGSZ6VBzNlG5Tfk+vYOmPXcpuijeiFKjIp7MYBLadXzCfE2ppuu9sUfozoNOuGGWU2aYtYwX15N6BEyxmHWjQOyWxYSPV977uQw3zRdk/w5IkVwm9eccEt5UwIIHfb02taTl9TPNoJnrxkp3vHdMrJRndbFsb2DwV9mX4Miv5K4EJcWG7pnetus7TkDp6tMOI6VFnMYGhksViefevwFiwHHL6ea8+smBFsJRIAivzFU6zPfaVV3Df4H6QtzmieLykx4kSDameCebvu6u2luLfHgKvUQ+qpFSPuqP7Q5LZj+TgcfDuJQ7OURX/GeGRVdnvJY5R1IE+BrZAluTYlfme75cuPV50RMMU8LBKukkREbH+yM/3woslZJlL/+cB845Z2RvXqLjKFs8audOAy01pkttH5JW6FiDTjHBs04NssIPw9TuB2EdHDOpHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(33656002)(186003)(26005)(38100700002)(82950400001)(82960400001)(71200400001)(9686003)(86362001)(8936002)(4326008)(110136005)(6506007)(76116006)(66446008)(8990500004)(52536014)(8676002)(5660300002)(10290500003)(478600001)(4744005)(316002)(2906002)(54906003)(55016002)(66476007)(66556008)(122000001)(7696005)(66946007)(64756008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNkdE0cdb+yJAFwRKKxgC9NH+kv+yr3NXelP/cu2+SLY3znWGhC64CcQa6hk?=
 =?us-ascii?Q?fedJItWKBzpyLOLp/sNAqc3c26TIaREOcLma8Slv9u0GRvXyEGPk6R9VYmtG?=
 =?us-ascii?Q?BOQYpib937Qm4a5mYVYELI+xJ+FOd7QnFFWXptK0BHeQtO7zn6xRgXOlWmyH?=
 =?us-ascii?Q?zwz/1AxFR7LVvddUkAK3eJHF3sSJ52l3IUudy3RjWYSkbGrtQ2qxjyGaMwsl?=
 =?us-ascii?Q?qJnZ1ZI+beh/SnxVRb5BZTbf65HNDO/47/2nUOjmidunw77aXZ6aZJukU8Xw?=
 =?us-ascii?Q?v/CYwXKdEm9lVLwJVGLsh8tR/gxp1IAwfIz8DW5kNFtMlr7ZhZioHeCySjug?=
 =?us-ascii?Q?edfu6V5LgYmQEk/nDuy69ZdTdAl10IpEsnfpNVlWDjqvexYomXq4akcoF9TN?=
 =?us-ascii?Q?bKeFomsDgzt7q5FetrHIRhZp8LcETb5KQBdhNmPGubiCq7bsHht8Gz8+TBg9?=
 =?us-ascii?Q?BOXkVt/b4shLIqNqCZAsN97fZG0R49WO59ZlACpXYbdXSwH1PmkXA3IYF8gH?=
 =?us-ascii?Q?ewSoZTkAqKqwIBfYQWXwUV1s7QrABlq55VZDSiYmSxH1f5+geMV1UoqkRxAR?=
 =?us-ascii?Q?9N4tlIzIvBTgl1U0RZnkf7w/Ut00QEunQq5An1gkYx5Hr1Ev/2vr2k2cwwBn?=
 =?us-ascii?Q?NJp8N4oGqx82aYgEi148aIVb0tO28AE+maNO/Zb8xlWahSGFyMrim4/Tcw3D?=
 =?us-ascii?Q?42PxTLuXZSIE2/rb7/c9oCTLaXlEpUQsjAh5HbslrS/CZaZ0F/E0kA1lJg0q?=
 =?us-ascii?Q?MT+Hdnbk8dUi7nxaFsP83YWFjX8PSceYhEJVC6C3jMlibJBT3OFLZTSpcNRS?=
 =?us-ascii?Q?Z3p27fBkrxJKCF1Nz+42yuikpr3ydAAZ8szrdAKs3ZreKqSNWpXf9IqU9mBk?=
 =?us-ascii?Q?uwFXCxNicdk/YruGIfBUvE5S2IBjJBwC1O+4OLSsmuEaDvklA+hynj9mK/mV?=
 =?us-ascii?Q?3mkDif0R/qdhDXwSKDctT5fjWPNOUifZysP0LrQjUG59C9nlxP8BBCbR7jNl?=
 =?us-ascii?Q?0hNNQqiiNpIoxLAmPoiH+f/GpRusJhNStC5cytRUcFHsJj/s1NBnLoLFiZto?=
 =?us-ascii?Q?TSSGToWJkXg3u4oAEKCv+clTyqjgPVj7atkFdM/i6ly8MhCM/Sn3FuNOnccM?=
 =?us-ascii?Q?Vtcu2zyMGrhnjZb7dTFYANWbS1f3Cy6hZFBKamPkxBF6ZQyX9ErOl/tfVBcj?=
 =?us-ascii?Q?jRKPNHBvlhesnvgONRIPKlwX/cpnsFXEOrc4TZ9lOiyY0SDxceDZznFRReYF?=
 =?us-ascii?Q?lbZdjvoQovBBeK/DhxaGT1XUgvTRJEllLcjS+4SuAyDZ9Ak7bHJf0nLeBKkb?=
 =?us-ascii?Q?5A8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75f7447-2c0a-4f38-6216-08d947149c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 22:13:29.3345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFnXyA4wSubDqZYjznWu5/TXjVnuroIo30JFaEye51xIx6ltlpmxMpUWQW9CB1/sFJBEVO2Ar57asCLGMAEyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1175
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> > +static struct miscdevice az_blob_misc_device =3D {
> > +	MISC_DYNAMIC_MINOR,
> > +	"azure_blob",
> > +	&az_blob_client_fops,
> > +};
>=20
> Named initializers please.

Will fix this along with the logging functions.

Long
