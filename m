Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839AD4934AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 06:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbiASF4l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 00:56:41 -0500
Received: from mail-eus2azon11021021.outbound.protection.outlook.com ([52.101.57.21]:19810
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236524AbiASF4h (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 00:56:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6aI7ySMrRzzP/ooU4II2X4GoMcgLP/vhd80VD1+/1pAlf9wVwSJE/iiDs/HpjiYGpnO9NYQcW22bcHNbqVi1E1+WSE5sP8UcrwattGCME3mG6RPEAGI3U3NVM+rG2FY0XxmIEC7A9GW5FvzKB/qRBEkO450uKgc1diXV8PFES7wcPn2R2FiRzZwt9B9jFWZzcX5zdkF0Qr0NdaTuwAXXOwvIox1V3rQqZoTM9eJ5qGhWwoQC+AViJGMKwBRnpDYQY7mYEMnq+YHAHGQ5DRkIdP+AbbM5fAuOuw8m/Xu/GXN3fmd4Qr1PiEccMj/Zx5pdhN/yFcmC8HHM9phlmFBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX8Q0M2sTwG6THoym6RCcc4w7aPA/CM6VO61Z/Sj7Rk=;
 b=iZwJYs95TCpnu5AGEmpEQnO4Bp3C2zFW3JoHb1yBSrgZCNVIaAj+ATnpDXsJIQeyxsQSX9lKaIUktUMMj/bje1tGapKFMS0DJk+SGtnuNkVvJ392QMzQx+9hhk0bJAyf1TJ8BqhhLIe4bbGH3X6ZJntepF+o6p2wtXqHg37JWVjnnwZI7gB1vGLpLysCaS7XanThhkDDFDrNc+bJJKew8RIDO+GJnJy7ivvtBdRISsaDDbE7GVaDIOdadtYflxBuDi4puRXCFMhkmVuVQqTDKhkLFShlPVIglyUsR3TlWEigTfMZqeu+Fb7LaDBGnZ18cgdGHiHW+pSzwLtPF/kJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX8Q0M2sTwG6THoym6RCcc4w7aPA/CM6VO61Z/Sj7Rk=;
 b=ahhG2xUUpF4442iIdsXRc+Gbydr43UOxHjyysvq25V04P3kj5TJ8W/e6L6dwF6GshxL2T864XuFplR/yBnNq517NtzAjFuhxJfIDeahBMdmnFRORC597Pc1CBS7hgdYYsP0HxU7JMDXVM4TprotP7N8N6TRgsppfXqhI8w64gs0=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by DM5PR21MB0860.namprd21.prod.outlook.com (2603:10b6:3:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Wed, 19 Jan
 2022 05:56:34 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::31ff:abb:fe96:b817]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::31ff:abb:fe96:b817%5]) with mapi id 15.20.4930.005; Wed, 19 Jan 2022
 05:56:33 +0000
From:   Long Li <longli@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
Subject: RE: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Topic: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Index: AQHYDN6qyjjh0/uAUUi8UkA+qde886xpw5YAgAAU86A=
Date:   Wed, 19 Jan 2022 05:56:33 +0000
Message-ID: <BY5PR21MB15067724D8FFBCA9F5847636CE599@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1642560329-5012-1-git-send-email-longli@linuxonhyperv.com>
 <CY4PR21MB1586368DF27F62BBFA12F2BCD7599@CY4PR21MB1586.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB1586368DF27F62BBFA12F2BCD7599@CY4PR21MB1586.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1c17f38d-7820-4d12-a75a-d77200ca2725;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-19T04:19:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc6c36c-4b80-4bca-ca33-08d9db1072ad
x-ms-traffictypediagnostic: DM5PR21MB0860:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB0860DA4F92E4AA08BF6565BCCE599@DM5PR21MB0860.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aA2OgOg+3BSK0GAxNOL9LwNZkfh+u2sySsEdu1T74jTLFBhdiL7GObF+OzinVJm0sCuSYrWVu5wPQ4YRqP+ciYQv/1DjqjmoyCjgLGc3uur0BpyE8z62R1X5joQC0Z2whhzJzji4h10iMR9VK15+5OQAeOvrEBd2S2JyRChS8Xi5lWPMxU4cBPoiadvY5udqxyebVAfjNlLniaAJPPvweaHBRy//s9Bgg0Stw4F5aLbCksANAeDS2Qn0X3O9iqhIhWFl9el9AjdIWqqxU99+sUqSbc2DTZUFoA1TpuOKeT/oEbiTb194yYbSD2iKl72Ep2NHSA5W9aaKietIWIbXr+hAzoKx/i6NL5KZEj0CSPAOttTm+WNeqWVFqX9XptSEV1+cTKs2eJiBxJtxsQPY4WEwcyyBnzq0ygtuHubXlY3oAdWcRHskWuX9+EsxRoP9wWJBum6iZNFWatoF+tk6AqE7pA82n/5t8pwnZqXBx8TKDSsPNITSbtukuZ1SAQh8sskFo5I5ojdHnOlGe9IhIRE0pUKrrNWQd58QKH9qDQa9rrKbi4VW8AHSY95/CR2+0gCwwsQOOyQWhqYBy2GfuevPn2Ni6R5J03KYdw2rq+MdE5fx+evyBthiGLDK6O+B4xDmb2gIoXaE+d7oZ15xTlJi4UMXlS8j9+nhBIQ3QaPiN9MsQAZ9W1UqosRTFAqkcNOt82PqA/qAH/w9o6n6poVgn5mmTpfH1a0rz62hJlMnyPq/ku/QANFeiY4MYdJ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(52536014)(10290500003)(8990500004)(71200400001)(83380400001)(38100700002)(33656002)(9686003)(86362001)(55016003)(7696005)(6506007)(5660300002)(110136005)(26005)(66556008)(2906002)(66476007)(76116006)(8676002)(66946007)(82960400001)(66446008)(82950400001)(8936002)(64756008)(122000001)(186003)(316002)(6636002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QPLTstT6f9ziW+wzUup7tgXLzuAZfM7n6M9DHH/ZzlI0c5SDqp25H5TnLU2K?=
 =?us-ascii?Q?7Q+V04pnEW7Kpy3qgBQN0a8OfDTOfoxGNik192MmfZ6n3syzCErn9DyADyMR?=
 =?us-ascii?Q?6wMAc0hdXGn0q32qdndOtPrCjwbxCGn4cQ1V/TmcOLxEqwuGjmtN1mFg3Pao?=
 =?us-ascii?Q?IH4ZdWgi8DKBglhJ4rZ/W3vWuvtoaRfm7We4RI4RSiYMqZ56eUKljDdJg82K?=
 =?us-ascii?Q?phIUJFPTYiI5iy78u55k1yJsWJMyJiMXt0C124L9LSLNw9AZCMGdTEACWl14?=
 =?us-ascii?Q?0K6Z/pQkNF6s4a3fDOJyLyQAfEiaisIIpJdzfkJtlP1CfQomviHzIQp7QlMI?=
 =?us-ascii?Q?A0xiOY0D/gVnahnGTRa5y5mtwMDnvIAdxXUQPQcJ+Z7NVw+q9+edZC8rjOuZ?=
 =?us-ascii?Q?HImz5JXAxSY32emzUQMTs++XYlqICyT/YLxz81nyEk48DOsS6h9i0SwbFzzf?=
 =?us-ascii?Q?Tn98Js7SdHPvQ76ZoGV9vu6vAv5ciY9ew9b2tueShw2JLrzAimbTnoQjPN+q?=
 =?us-ascii?Q?YnurY9YgIs9Qpb7tLcIZnfxgi6FdIvp9pOTI73SD0/bJilZvjtQbC5NkJsJM?=
 =?us-ascii?Q?CchooKQIS/3NwoWGAsaFL5R9Ntrx93zFtaat+75PLV7Cj1cIHqMaVZJgVfs7?=
 =?us-ascii?Q?P87TibcGG+Kj6zGvhr6Pf9jH1g01QDjgp5XGpGX0wcPAUot1QHbrEdgR1XQZ?=
 =?us-ascii?Q?KJDfe2NH9Q1LKusMWDn2RwDUZhwj0/ymXrcfyP4dFRml8aUZAD0BC20pO8Dh?=
 =?us-ascii?Q?Phdpo+AM+qFW/HLJJVYJTRCJCitGAo/SPlc2lB0e+2083LxBSNV4HbVZAfyW?=
 =?us-ascii?Q?9p1NLtyixrx7KIanTjnnDJRIWXYiwL7AHnIy13/TpED1iZvpg+XH6lSwPZnm?=
 =?us-ascii?Q?3JruQ/gA3wo4ssepZdf032sgE4UnnoRUq6awwYwU5r+IrkPx76o/pa0NMZby?=
 =?us-ascii?Q?x1AP1epYuLwT7ltMhyxK6Cxs5lqsQ/dlMYrTaWR+n7WRS18VCv/VClAZ7MeY?=
 =?us-ascii?Q?e8yKRrG7KRKv7Lx89oisJWp0wvjsNlnXUPIdSLcA60BY1/r77HLeR8CfTE5c?=
 =?us-ascii?Q?jtzLYRABxpddevglcG/iRK5odxHxo2yovLbe/hN6PFa1ExOJcu+vgGkCbSxq?=
 =?us-ascii?Q?i+vtq7Q7uaxrwINIPVbKfDiO6J/4Ay7dlSB27MYJ3nTKDuYsdcXE566ej48s?=
 =?us-ascii?Q?tazQTMK7+OmOfi0Xlx0ZCatuicsWrwHWqwo8x18iRN+RlelGMyq/oaAOAnAk?=
 =?us-ascii?Q?xq7GZIN0KnaJ++/n21spH3SAEq4EY75NO0cXCa7+BLgBarTFzgBbYd4hwA01?=
 =?us-ascii?Q?dicU6y00vCOxMftvmcfAddrPR/sXNlqGc8Mnm8JKRzXL8X5b+gyLuo7g0lTz?=
 =?us-ascii?Q?X7IbBDNrLK0BxHKrc6wfPaw6KZr8US300dXvV4ukTUjIDZqwDvstiYIZOnS9?=
 =?us-ascii?Q?eo9bDBBKk1YbyGQCp7tlF4zHCwFliPEKR7dZvx2Xrc2IGr1Uu/LJ3aQgYjxE?=
 =?us-ascii?Q?LtSYN3FMd9qZwouu3xivuRQnzKtqqJjCKmfUdzrwQvRA/HIiTVVDWFVqh2+S?=
 =?us-ascii?Q?319nC+j/2niQW0ZKjTe8Y7Dtt4Iy2laf7fw54/12bY4mwqe7vUVjE4fAqpuY?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc6c36c-4b80-4bca-ca33-08d9db1072ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 05:56:33.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftUbTPCmaqM8QqhNOOj5mJ0KDTpc3rcCwgBEM9IlIgXL+RasdfJP04FdSrqbKsRYH0HXuAbJ5NMf6tJY6VjX3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0860
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boo=
ts
> with custom NUMA topology
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Tuesday,
> January 18, 2022 6:45 PM
> >
> > When kernel boots with a NUMA topology with some NUMA nodes offline,
> > the PCI driver should only set an online NUMA node on the device. This
> > can happen during KDUMP where some NUMA nodes are not made online by
> the KDUMP kernel.
> >
> > This patch also fixes the case where kernel is booting with "numa=3Doff=
".
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>=20
> It seems like adding a "Fixes:" tag would be appropriate.

Okay, sending v3 with "Fixes:".

>=20
> >
> > Change from v1:
> > Use numa_map_to_online_node() to assign a node to device (suggested by
> > Michael Kelly <mikelley@microsoft.com>)
> >
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 6c9efeefae1b..c7519add6f13 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2130,7 +2130,15 @@ static void hv_pci_assign_numa_node(struct
> > hv_pcibus_device *hbus)
> >  			continue;
> >
> >  		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> > -			set_dev_node(&dev->dev, hv_dev-
> >desc.virtual_numa_node);
> > +			/*
> > +			 * The kernel may boot with some NUMA nodes offline
> > +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> > +			 * "numa=3Doff". In those cases, adjust the host provided
> > +			 * NUMA node to a valid NUMA node used by the kernel.
> > +			 */
> > +			set_dev_node(&dev->dev,
> > +				     numa_map_to_online_node(
> > +					     hv_dev->desc.virtual_numa_node));
>=20
> Double-check me, but I think this approach has a flaw in that
> numa_map_to_online_node() doesn't check the input node for being out-of-
> range.  The call to node_online() uses the input node to index into the
> node_states bitmap (of type nodemask_t), and could go off the end of the
> bitmap if the input node isn't validated to be less than MAX_NUMNODES (or
> nr_node_ids).

Indeed, your concern is correct when "numa=3Doff" is set.

>=20
> Michael
>=20
> >
> >  		put_pcichild(hv_dev);
> >  	}
> > --
> > 2.25.1

