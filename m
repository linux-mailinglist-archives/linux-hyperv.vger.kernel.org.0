Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF73699BB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDWSdE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 14:33:04 -0400
Received: from mail-co1nam11on2095.outbound.protection.outlook.com ([40.107.220.95]:36961
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229691AbhDWSdD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 14:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoJbsuagWor5UWUsrj2Ev06cl7mbImLaazW3SHQpOxluvYZJqmck+ZVJKlCdkBbxRpVed8kjOatnW9NXLvprr2QcLZgqa2dJu0numRoQonCitivfOYucJVHgSu3E3y8rdkJDAU97Gdj/k5sTJ0xNss2PH3NwSqF/jSqzgPYi+dLPn66Ba2mvmZJcGjrD8nFTATtLTZxhCpyuGIZzdN9IiZaimM6cTzPXby+XR+0EGE/tLGkG9UMv30QYvO64+uz1gLrAfTUYhaQ8ph8qqGpK0TjzbcQO0siGjMOYq42LcZvdjT1T6W5I3YlvgcpGo283whTduwCmqpRjA8kii4VMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1eYiaL3brpENw+NzMw4ggunRuxiY/yWu4xptkH/zpg=;
 b=MIVcT7iMhMfvwEa8/3K0Cg7UHRs4ghVsyyiQk4vLlvIRY/ptMbX/3gr/11DeQxfWSIcC8wxw8adNN4N3DqNOk/wBSVXOgsL8ku9yT/tuZaCM12i7ZWz+VwsQpx593BAW3J4qDwNLdPmKvmIJNcycx48kgVpb6xS7nqvjYNJfu7Lnw7To1uM9jjHFjgIGiI7wFd5x2AMc5XtZW0fLwz4uFuCaE3NjVahpzTMTvjqZtTVvd38H50474t1JAwxJRUpVjh8Z99ZRPWEvn7mfNEV6XDgOi2o3uxoYzpKUH+YzJhWkMcD3uvUCME6qty3/nFBwrGH9uZ6tZ2Iw69oYra8LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1eYiaL3brpENw+NzMw4ggunRuxiY/yWu4xptkH/zpg=;
 b=Do98JKwCnPPqJuEw8sNSmtkDe7GL4VIiGSJGlAtSkgR61okr9lbi+CvWnM2APS5fp1XqjF8i3O7EntO6oJRfG6JnHX6SCDeQ/SVFw7QLbSrpKNtGT6wFWAO01/w9c1zhxy4Rm66v+KTMSPoUBAQX+UNYT4/uVsZHcM9NxHKKuWA=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BYAPR21MB1238.namprd21.prod.outlook.com (2603:10b6:a03:107::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3; Fri, 23 Apr
 2021 18:32:24 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.021; Fri, 23 Apr 2021
 18:32:24 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrFBLwYwYTj8kqzheBKY3VooKrBsNwAgAC786A=
Date:   Fri, 23 Apr 2021 18:32:24 +0000
Message-ID: <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 164a47f6-9ec6-40f2-ba5e-08d906862404
x-ms-traffictypediagnostic: BYAPR21MB1238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1238DE2AF7A27B42029CBB50CE459@BYAPR21MB1238.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AM1C3dADYcyEKpzY8DDVkad2aFolafzG+pXip7DTvgFyEPlBbaEaFSa9kuSb7fvy7LEH4wdKdV9jgUAAHZ0ZUYNbqt6CO/ojs4lZWvFZrly8MW2PSB7g4XKDUupobP+UyFWbqzVpXvffnPoTrdovchaQjhnhLP/3nsYNJgJDpTCQQUG9TI2YhmZYwgfTPYCyY8Ac/oEApG/yE4kEBiUEsZUrL/07a0phH9Fr3jPbDpBRpG6jMF/zVjqYPvonJoSQMOrbjTppzOvMDPQk/Kx/ha2X4qDP//DslcoloHpUjwiWkslJyOBjfC4lVj8VSDoKUbU8Kg7PZ+3vOlGzMSREcf22JDeMOCTeF0OzkvfJvQ+Sb3cXz8DtBuIF3SYXbRhrndD1MBbHIJQn75QaKs9wqtS359IheB5tin+T4+mK1hcjI4Mtp6TXRlN6Vk765px8TU1Q+7BoYeLZeyvV88vLQgfirr8j4sEebLN4wk3xKczBO8e0+EMjNFkJNtjUd7OFklQTarqDCKZeRTxGv8sK+L+tkSVkrt7N6rMmX1Fs/z/4mxRjEX0JWCWfn2sVu6VcYfngwq06tU6JTkO6mwJlMIxdD8h74+LNhw5eldm72XXV5Ju4icLXrXnKfPsRfgJtJjnTVzIIC1+DVthGCJ+rdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(478600001)(38100700002)(8676002)(8936002)(122000001)(110136005)(10290500003)(2906002)(8990500004)(6506007)(5660300002)(52536014)(7696005)(55016002)(83380400001)(9686003)(82960400001)(921005)(33656002)(66446008)(66946007)(76116006)(71200400001)(82950400001)(66556008)(316002)(66476007)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2ljEMYYLINhXW5VBevHDdJotgXj3L2Owh+yFhYeVLpQb5wxz8TMZYHpR7/wP?=
 =?us-ascii?Q?C+8gfcAJXUPEnZvPRt9m3nTxPw73s/tozrBsSntp+CV5Pe3waW6ffbseM+rG?=
 =?us-ascii?Q?7i4VKawk5GEcXFLQlLyH24K5KTVL/t6VWo1ew9Gw95kdBwVdxFnEIgliAL/F?=
 =?us-ascii?Q?26GrMACI2wBT59gWRfCiWQbH1FVNn/C4p1z3Pan0v4ViCGwpQGCeWyU5diyx?=
 =?us-ascii?Q?obqjjs7HG5stKcBR3j2hrM7x5BUv+tzDk+s23T24tfWTsU8CdNqJ58aO2vvx?=
 =?us-ascii?Q?9zww7gLgU7eBG3QXQ1JAiJtTmhvVaH/pjGEkxqSNyH0VbU8KDCVB6SElHZPo?=
 =?us-ascii?Q?T8qEgEQWAg9bPKQAMTVPMLFAJujSwO9pIR1ONaLPVzepOYoe/Sryw43xjkAu?=
 =?us-ascii?Q?hmvVBK6ZVhecrfSpZ47JRM0pVDKeo0XtGaZ04Is+alH4n8l/Sn7+68OUok8H?=
 =?us-ascii?Q?8HAYYNchCL28TVQ/vdAK4H8bKtVXFiUxyNxbuZfxA/jeFzzQBti1/uxQ6yaT?=
 =?us-ascii?Q?Tar39viztWFmumf8T+9hhfZPtOgmZzqmggpQUAY3uabiA0IwIsRmYDgH/OGR?=
 =?us-ascii?Q?cOPEwk0i2uX2JpJo+pwLeplLiRb4gXy4eJFvGLygdLXSGNxsBvnl6S9orW3F?=
 =?us-ascii?Q?/itHXx+kxSBE57cjoKvc74GgHi8kekCzaqtA5RTBfH9g4xtDdLTO+v7Q0r89?=
 =?us-ascii?Q?SBCRu+4kAsJdyq6uzt901oFkoRfBJc9pP2gx6EZO+2gXS03yReGOhB3PSikr?=
 =?us-ascii?Q?yE5va/ZCnMmvXq2FjeJsYWaowLPPsrFep9Z9ll+I2xKXI5/eqyRMb3YysaMD?=
 =?us-ascii?Q?Zcnp3B1avXFNCDBf5CmXoHzxpyxnZ81Wl+pd0HQJMMyRcOcJvDrTvsMxsv+M?=
 =?us-ascii?Q?eYbvXZ+yxpqzh9VqZp1OhY/sOqvzj6f1xBopSn/n489oRuEQKzHnho1u56po?=
 =?us-ascii?Q?6/3c/4C9ObW+cBXmOYxqlQad3i7KCZOgWsA8Cb6tMf5GSzQRjvv1fPCZLtDL?=
 =?us-ascii?Q?knZhRSINQiygFsjeGFUQ7G8ls3QCYW4DUsCY+NFiWrercMo/6VuCJVdV+8PH?=
 =?us-ascii?Q?29S7jwGye/BzwRirJl8dSQAJJ5mk/NUI9bx2oZYspwZ6lKq3703PJWXN88VG?=
 =?us-ascii?Q?jPeINDN2QobFjISKyq+cidLv8OEltoWh6RVc83EyO738CTDnryIzAHJ3tXoP?=
 =?us-ascii?Q?pzmS+l6ieYunZmy10AEvhXnWmHK2kMthXZi05m1Nu6Fpeamt6SxdR0MltNFk?=
 =?us-ascii?Q?+QsOphmXVWzd212ddeN6B0XA6zbOyePHp5hcvYmynLhpAyQVC6HRzolcyVs5?=
 =?us-ascii?Q?rPA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164a47f6-9ec6-40f2-ba5e-08d906862404
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:32:24.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBzJ1B1Ht2NGR3Imns6pdxYNWPT/opGWX0W7gPCB7kXUXFCcmfh4hDZqrBRvUKOtiQq6V8aAQ+n7GbxYiWAskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1238
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing t=
he
> device
>=20
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > Sent: Wednesday, April 21, 2021 10:46 PM ...
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 27a17a1e4a7c..fc948a2ed703 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -444,7 +444,6 @@ enum hv_pcibus_state {
> >  	hv_pcibus_probed,
> >  	hv_pcibus_installed,
> >  	hv_pcibus_removing,
> > -	hv_pcibus_removed,
> >  	hv_pcibus_maximum
> >  };
> >
> > @@ -3305,13 +3304,22 @@ static int hv_pci_remove(struct hv_device
> > *hdev)
> >
> >  	hbus =3D hv_get_drvdata(hdev);
> >  	if (hbus->state =3D=3D hv_pcibus_installed) {
> > +		tasklet_disable(&hdev->channel->callback_event);
> > +		hbus->state =3D hv_pcibus_removing;
> > +		tasklet_enable(&hdev->channel->callback_event);
> > +		destroy_workqueue(hbus->wq);
>=20
> If we test "rmmod pci-hyperv", I suspect the warning will be printed:
> hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_start_relations_work():

In most case, it will not print anything.=20

It will print something if there is a PCI_BUS_RELATION work pending at the =
time of remove. The same goes to PCI_EJECT. In those cases, the message is =
valuable to troubleshooting.

>=20
>         if (hbus->state =3D=3D hv_pcibus_removing) {
>                 dev_info(&hbus->hdev->device,
>                          "PCI VMBus BUS_RELATIONS: ignored\n");
>                 return -ENOENT;
>         }
>=20
> Ideally we'd like to avoid the warning in the driver unloading case.
>=20
> BTW, can you please add "hbus->wq =3D NULL;" after the line
> "destroy_workqueue(hbus->wq);"? In case some other function could still
> try to use hbus->wq by accident in the future, the error would be easier =
to
> be understood.

I will send v3 to add =3DNULL.
