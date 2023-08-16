Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257D477EA6D
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 22:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbjHPULD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbjHPUKd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 16:10:33 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA7CD;
        Wed, 16 Aug 2023 13:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j958MPh2UBD8FZnEVQ7cQbJwlThqjxlqssdDNYqbM2oiYAShD9HcfUpHbYQ5QYLw5oEVnamne8/6OaUcyeLW3yXYYFbhvcTFJ+VFtkrF5bx4/Q0rhb/ftiL8QNvsYYhY/ROAMvprAwr1z2YPv3mNQYD60ADNnHXp21Zz4EXlUA9PMHg83bkitV2wxjQg3FXZn5Qarm/hLaq0BETRlBbszNdMHIxi+6HUg7Rh5PiQJFR4+LA+7ENnmA0Aj3s+Bkcjr+2IuJop6ZZJC8jY44VYDoYtQvTCuye7qBKUSj5RnilkhH3Y2Ri801v6Vr+O9DsEUAGJqWr2KFZGKFHTmLgbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU4ssg9noqm5fEUxtUtjI8A4n3+lH7wuGWRpq8Zjp60=;
 b=fGJBulI18hQpE6E99+RZ9GQSUc6mmt7+cTFqaripkshAbM/08Ew34Ikml13L9nWmyGkw8QmKQbSAw9VqqycGPVRlM5T3tIPhLJ3ypsC2ffPv8XPXFYFUUPU5OFmZx8i11NdE8J7Sm3KnmkVNsbPUExFdN4YNWhuEyDafF3YB1hs/1FZ0OJrK+e70T2H8NDzfFfUGwggvw/Lc5K3ypS6wRG/aR4Sl/AC/jUBIB5Nxrdl+pPKmdo43TDZjPAtHQpbdFTGCmiBqFcf9CSLeeDi7Cc6GWYFdtU5DSnrSOJl5k4TlzX4Cd813WWmE/4J72zjnvPHL8ynOm8xNZ2li0nM2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU4ssg9noqm5fEUxtUtjI8A4n3+lH7wuGWRpq8Zjp60=;
 b=Na9Uzofz4whZSWz0qhWlq5Okpo/a/8CNK92r6cfDW3pbsMIgZBM+Vc4CF+5ArjFsjztYsI14DAUvDWUET/6fcPYEjWY/jQ1KDN3ciL3/XRxYkXpHHYq+nJJ0SoREq1MdXPP7v3BWRdK+wG+lxhqztnl0dR3umJ5b7/EZwJ2yd9c=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB2079.namprd21.prod.outlook.com (2603:10b6:510:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.12; Wed, 16 Aug
 2023 20:10:26 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Wed, 16 Aug 2023
 20:10:25 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Topic: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Index: AQHZ0GuE5zabw9X6M0GN8g9RKTsDQK/tUjSw
Date:   Wed, 16 Aug 2023 20:10:25 +0000
Message-ID: <BYAPR21MB16888FCA41CEB8569685FBB1D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230816175939.21566-1-decui@microsoft.com>
In-Reply-To: <20230816175939.21566-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2ad53e2-7dff-4b92-9963-ff56193ef12a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T19:40:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB2079:EE_
x-ms-office365-filtering-correlation-id: 5ad82cd7-1a4c-47b4-aff1-08db9e94d44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cOQuyszAQqUainGGF9gW9H5cXmDpcbXtzONGYkvGI/coBBa1ia5iCecQfQPnWpIAYwk4OTiqUAxNdrwq163GMLv2vLPBAJ79ljyuG4/moF/TtOJxtqf278R9W6cC/bVwZsnu1JjFOyMleZV4Im1odfhLVaOa1OdCsKDbjW6FMfOGef3inIDzl4l60oAD4s9tQ4NwIOqrZR/Ff7aNRI0PDVShRTrp9B8d55h2+K8JfID89zabZTySb9z6OUBCgwhiD4CQ2Rv+pNtdSOyTuH5WbV9LaA/uuuRRG0nkjARHmQ4IXnz53RQsr85M2IiiQEbfs3wi0/6q/VVVSZN6Of7AV5tyU9MoJlAdqYd2rCj3jaIsgnvi2EEcyBlwwHWA/j5KZBtlkhxmutoKEcdIadrQTsgfSmFmzu2UvC3AzEfwYsqTpgGbv81UHLtVGoMO/btJ7s9wzGcwb85eKZ4cWWZqtElrEsjcYF5bf7FdjP6tfi7F7qkNnQaBKfnwzRc/8XnBzFV+/YPMLNjj7xQTiQ5h+guXx82zzTEJTXfL7MVT9KGBV7e10S/YXJ5UcOWPOlv9lsnRTHch0+yleTm7GEa+viLxQAJJ7AFU2O70rheN2KzkEgGBegbmL/axx+1sak7FNNXqjmpfQSXW7azkXYkeTaswP/3yFr/6D2Le5CekbSA1gc34Bgrg2qhzA8QOi2W83yUJt/lvrUVsK78RGdjFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(12101799020)(5660300002)(921005)(55016003)(478600001)(10290500003)(110136005)(9686003)(7696005)(41300700001)(64756008)(33656002)(2906002)(82960400001)(38100700002)(8990500004)(38070700005)(86362001)(8676002)(52536014)(66556008)(7416002)(82950400001)(122000001)(66476007)(66946007)(316002)(26005)(66446008)(76116006)(83380400001)(4326008)(8936002)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47xduTcWJ2PUqFjkkHl+Qod5zFSNrmpvD9uxuaSQBsEiIba5nzQQBbG+4ruD?=
 =?us-ascii?Q?P+4pOfdh6YPCJRgFPlkcC0HPcKDadSXf4IOAfhYeGZkSmNIE5AmUyWkpgvlw?=
 =?us-ascii?Q?2Hg8MuUuErG+mCMQ/+V5+w4iWTXhWyx3xXdafPkbob7wqWFSFUBCfZqAw14S?=
 =?us-ascii?Q?sZwKGcDxgrvxhv5rewC3k71s2A0bUPPKQKEnWa2TPzwFocf9urc131/nZ4wv?=
 =?us-ascii?Q?L/RRqg91Ylar/tmJ4XdzLJtBiTx/UKXJGNLtFupnBmRi3xvBHKernPO5n+G8?=
 =?us-ascii?Q?K1Rb5GoPZGAZSINus7/jOEcxRV/T4IazSUuqMbjxYWIsqlj/IIKepJGo3cFA?=
 =?us-ascii?Q?0QX0ohdf96U89eSahJ6OW2NrC+vbo8W+Y8BcP4IPa1uVnUBxTQpYoiPPjk9q?=
 =?us-ascii?Q?/M918kWvthp0Y4Yu4EaNYJAMcRdy+oG24epc/lZFfs3brXLa1WAVupKRhRWQ?=
 =?us-ascii?Q?XVSZzPkpR6/X6xVC5PsPaxjyF4eqoPKZmxMxBxZfnwL6+bllHyFSQAW/7ifn?=
 =?us-ascii?Q?NQy1DzrOqaJjh69AAtW0LLD9CtYs2RdBqZ0+gqUVoEI2b53Hb/m6f0dAhJHI?=
 =?us-ascii?Q?bo428IJEp3GGgpM4XAPVZejCRGJFvN6bGjTIdsTqMmdqn9uwTpQ7fq50794Z?=
 =?us-ascii?Q?SxrLb229LCJMii3Rf9O2l9eCO5Kd1vBnKbX7MF6c4HtHmzziep6naDmL9FDd?=
 =?us-ascii?Q?akTU3bI1r/BHZ0MOXuGj4Q5I3zNVlRI2//Wi5EjZyqklxe9jcms4xogSvhHS?=
 =?us-ascii?Q?03Mi4bgY9X9YyhcBRT4wE2xxMkZ7sLvTc5FyNRLMZ8/NbSYGT9WmmEJPGpcL?=
 =?us-ascii?Q?q7y3VsWE/+CvXwqe02o3Fq9zlHmuCjSL+NUYcvAQRddSyowMRFIFhhOIV0Um?=
 =?us-ascii?Q?s6IZORHe15A31cXaVmJteFIlO41lOThm8B9MSOvWByY9D9EsAuZbBEnD47rE?=
 =?us-ascii?Q?9n+hbvG+YHg68FwxOlGwCP0W9mIlQsTK8Jly5a9sQX0kZdr8XnKn4ts4RYxA?=
 =?us-ascii?Q?wLpwOuraq5WV0k+KiPWW0weamDreQrOIgWvMXbKgORnDwk4hGztVE3Xo5qdl?=
 =?us-ascii?Q?1xRPFQN7edfCgKaqslq/lrSHN+QPCnrhYjSNtm2IgwUTKZl593iwo+GT4/C+?=
 =?us-ascii?Q?6vgCUxVe/0aqMsx+4PtmgUxT/8yCf/BX9+s8tZuEvcjrzAZdixLs5aS02LBA?=
 =?us-ascii?Q?vNl+up19BXC/Vr5mS2BfGAuf+Qe+ibxclgHmviBKqy0HhcPWfeAANjwCQsnQ?=
 =?us-ascii?Q?Yj2xl4EP4VOQHeW+fn6IsSv1DIB9++VFj6lfEBGMciUw8xtDtJEuvfRVEBtz?=
 =?us-ascii?Q?9o0GZYxENPkEdEiVVl0zAWKooGFmtFMyfs/DE7nXYlvxXN005q2Lz1VJBkX9?=
 =?us-ascii?Q?OxKcs0fnI8SwFDJTOqo5yZ7Rf5ukiOrypWynzoiH+RxaZ9HBF2ZfpzyXUIgk?=
 =?us-ascii?Q?dqxCNHDvV6t0/d0A840jRTBjll611h24lijvEgY2biy9ylY0Kl3ELHWjWXWY?=
 =?us-ascii?Q?P0Z7t7CcuQrgWYDCYdq/xlCoP7YsF/xWjk7LlIaN0jnxUo1XZ1w2hAm2i7ca?=
 =?us-ascii?Q?QIvt95dvw4n3cjWA6LaXu3VbtkJ3LJc3ojSTtaX0o+En6S+MdPs6yDmYhHsC?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad82cd7-1a4c-47b4-aff1-08db9e94d44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 20:10:25.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAAgscOSqIS2wREcCNPmDrlOgo1Rhjx7JsMjh6JGSE8ZHpDS3x0ZPQamwQYzma+Imb3o5SKDFRAGwPhDKQ/AIQ1t8ljq8socmhgh4JXb1dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, August 16, 2023 11:=
00 AM
>=20
> When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
> device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
> device yet), doing a VM hibernation triggers a panic in
> hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
> pdev->dev.msi.data is still NULL.
>=20
> Avoid the panic by checking if MSI-X/MSI is enabled.
>=20
> Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
>     Replaced the test "if (!pdev->dev.msi.data)" with
> 		      "if (!pdev->msi_enabled && !pdev->msix_enabled)".
>       Thanks Michael!
>     Updated the changelog accordingly.
>=20
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 2d93d0c4f10d..bed3cefdaf19 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *p=
dev, void *arg)
>  	struct msi_desc *entry;
>  	int ret =3D 0;
>=20
> +	if (!pdev->msi_enabled && !pdev->msix_enabled)
> +		return 0;
> +
>  	msi_lock_descs(&pdev->dev);
>  	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_data =3D irq_get_irq_data(entry->irq);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


