Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12085E6FE2
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 00:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIVWov (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiIVWot (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 18:44:49 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097A5926D;
        Thu, 22 Sep 2022 15:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNeCZ5ThaY2MzjMm0bAqaQidpLW70O2yg9aepazPZ4bPnPKUF65Iw+rrzAHNm203A7XTadnFTDMcJJEKCYyTDom+vMNP/g7YS0lnvQNC1bJ7poxSI19JZe/ixg2SyMKaVef/WJS1FuW6SjPI0c+pm06UX4wXFtYRjYSa7LxeOnkJsl0xmyB+tvgtAihpwkt9Q6y6AeD0kzxiuXfH5f1WRSYNwlADY0taVQyhREJbFNePA0YkkD1X+RybFJOZS1ZD3VBXXX83g2iOqgEuCnFP8DI+3RuItOs9H7k98xViY3AvsvEdX1fJv5uyLnJn+clKPTpWFF/MuhVrfSGNsiBYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wAlVbwlsA5L5jz8l+84GsDlBIl1YF6hyH5mDhn5l2Q=;
 b=Nqis8HRFe1vk21Pmffz9UaurUuT0tEAxJQDTWXtLJ9swypa8742WFro59lS5lMYI+U8ml6UbqiSfSZIw0CoB+BnnOJIkb+M7IavEsPRqzXWK6Vf7osuEeQpQoFRz476AG2m4GqDlmBgIhEBia0mWWRtKtvzLGJrubWjsDqkNwGkQ69LibN65q2knTwh7VN5yNV58owX2S0v9VUC/VEFvTJAJM3dZBayS7wuMUWqddESZrrcnlWJncosxkT4jeT4Wx6IYT8OR/d41J32FwwLjO2OOy+QsKNRSq61t60ZPRNghA64ZTQ5QTOCKXQ0qOS3EYkzkO6+5iibhmO2ruxuNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wAlVbwlsA5L5jz8l+84GsDlBIl1YF6hyH5mDhn5l2Q=;
 b=MFzbyDAF8uWD/dadgI+fmPYgODVHzLeIYO9QvQBDWoAQiD41HhZFXSgQBqDkYvZtpFx7uYMYEtoelacNjnlS1USRR5tm78YD7HTgA8R0b4rjBaiFPrvXP+RNWEHyoP9IRg9QOKwMYNM05izMVb15Z8ltYEGY4K/WfLJ5JFy+Dq0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3657.namprd21.prod.outlook.com (2603:10b6:8:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Thu, 22 Sep
 2022 22:43:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.007; Thu, 22 Sep 2022
 22:43:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Easwar Hariharan <eahariha@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Thread-Topic: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Thread-Index: AQHYzHPeGYBt742ZW0uQo7451Q99LK3sDzPQgAAAmGA=
Date:   Thu, 22 Sep 2022 22:43:24 +0000
Message-ID: <BYAPR21MB16884931135424DA3D67E497D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
 <1663625084-2518-2-git-send-email-eahariha@linux.microsoft.com>
 <BYAPR21MB1688949A28069BABBA50027DD74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688949A28069BABBA50027DD74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f200e420-2c9f-4094-a4eb-1be64c8e6b4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-22T22:38:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3657:EE_
x-ms-office365-filtering-correlation-id: 07b5488c-71dc-47cc-8815-08da9cebdb93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvDN0/j4OXkSe7x0gL+C566wK7XmEQ1yUyk6mwrM7U6TgnSQisK0FAroJdIF2qvqcT1Q44BG4C9Oo0SZLKnFPsg64btNMmICj6stuAXRplT6lzWQ/pVx0xpHjX5AXlcEVkbiFZXwKaiinn2TbUFCqup9e2WS1nDkD1+A7Mkq1fXd7tsc3iivaWCsz8eb47a6cKhZYRJcXxGve9tkic4xvD978HPXz3y/t9BCOJDN9Z6yCOUwXVATJx7ziWFNbrkQBRehHV+Ja57Jl9XVbUD+qLIKiRluJ5p4l7RhVMsDqwI7u7wpWfsaSA/kox6ZTvKqQy21poitWIYGF8a6yRQLS8ORJMTKz0UVXox/99ixsD0ZkbVaAbh4sbh0hr3yslbkBXiLVY9hHXT2V3SuTT0R1q29j13K3oU3Fizu/e9HwJrxRCMpPeYAm2/JCQ2Q3Jge2sFW2yYkkHMrUwIuI3C6de4miaETalIFQt8nCB1Jva/VcvRQhIwugO4QOwW+icfLLsCgcoFqxUqDDVBBsHzRyndANlAlyV/1JshVNvjbsrA6PZjqsOeH6RJ354FCujmuZ8B8yfiS0R/hmisjlneoU5yg6mbeRpA4EtoSut+dkEauAJE/xGulVKNZ/lTaQwAbCq/Xah+OrBxxvhRClEjD3NSNv9gcjnZdzCu951AdzqpWCfxHoIipiXEdQ6VU+//ec/BwqOgeIjgjldGeUFNSHPP3/Kz7H2YrIlexYoBLu5ucDKdgthn9aKb3OfLNoqxBTApGadP2Mo7BmKL7Nm/YWGeGYaUhRNVhnIhRfcZDXhJ48LKyhwk8aRUvcLzCIhat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(47530400004)(451199015)(66476007)(110136005)(86362001)(71200400001)(316002)(8676002)(10290500003)(33656002)(5660300002)(66556008)(64756008)(66446008)(52536014)(66946007)(76116006)(26005)(9686003)(41300700001)(2906002)(186003)(8990500004)(2940100002)(122000001)(8936002)(6506007)(7696005)(55016003)(83380400001)(38070700005)(478600001)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpRrIK8XgRqVWj9z84K1aUwWdl6qBocMuxCwMOuzJvdvgqotQggTvfKoBmLR?=
 =?us-ascii?Q?vX658vxPaqLzBd35O6gFJxSIAza08wwjIw9SBI9LKieefXSZ3OdynHPX7o/y?=
 =?us-ascii?Q?C6vv5R3iT9eiQQ+KDhmktkPq1VSr91estsptpfMMeuzX0zYox1foJqUHSI/F?=
 =?us-ascii?Q?/3nfBk5W00SXzKFY/YARD9PQqbYsbXhZSckblQg0BVeteTkh7vqt4/g2b2Ml?=
 =?us-ascii?Q?qQPZ0HKi4GekBcjnBe4Q3Z71zhQ74L1jjk0kPbM8i6YBlglEycqysHWubglP?=
 =?us-ascii?Q?xWXwMEpGW2V/9RvRhDvL5rsGKOI4L5qa4bQcLzix1anyvI8X340ru9GGAE4D?=
 =?us-ascii?Q?Gbb2aKVvFh4P/v1d6w6Jha3cFzZd2Ll9I2Ov7Lx793re0nqoXS+MZ9TCExiF?=
 =?us-ascii?Q?P4J/ALUrBkkhr8v70h3dW06Jn1Uqrqy4DEB/JU3JUT1VZQbRdl/JAQVHAZjH?=
 =?us-ascii?Q?uJAZDRPb8TBANx1Xv8RJRTU2EhPVz3eI67jg3kVDG7DkMJ+ki8ZSJt+HoMFf?=
 =?us-ascii?Q?zSlPDOLYYKTn8vW5jkvmVxBNsA6iNgCypx1qAcPC1J/VWJhfbkLs9Cb3PtZh?=
 =?us-ascii?Q?RLJKgDoYyrwRcisoHHRJjVNW/Vm4jIBnFrnDvrEeeQGAs09ipc8xLX+qnTyK?=
 =?us-ascii?Q?Bfh5hXYGDls0fDsy1NUsicQqStDdD++z9Z6AhukpjfjFsNctqpXT/uXYouys?=
 =?us-ascii?Q?xbj9BMfIgw6MlfjZatNhrZ3q8V/1gwqJpgoQR2IYjrvfB3lS7l5zIFUqBgOz?=
 =?us-ascii?Q?v5IpctHLUk3SqTXSIYcUKYfH39lPOowE/9QOBnwxcSFMLNXyzYiyk3ScTzEl?=
 =?us-ascii?Q?wF5hxCjFH2FFIYfm4w2vrmMzAH8t/g8IqO6TMd8EK0Eic/IS5MKDsgKXDA8Y?=
 =?us-ascii?Q?N+zYtH9gTSRIIvAcrI8zXidFojpzC8gjiUTKDUw+y3wTUWviW255UKoMPgkm?=
 =?us-ascii?Q?fPpBKb0caH1oU2kkbAvVidmFqFbAm0qX3r/CPnCQJR7VtewssCRgcJHDDUBi?=
 =?us-ascii?Q?h3h8nQNxsxk5ATba1S/7aAlxGcsL7ZggBhr5Sf6UIMwV6UPXg+2+n0kieINK?=
 =?us-ascii?Q?2XUbhqtrUgJ6YBmo+DNPFCcXSf3Gu1rdxB60Vc84CTZH8VsZnrmO4NLlng5N?=
 =?us-ascii?Q?lfR4ZUKm1NYxu9x0L9F/GpPOIspHbtTGnXXzrjqc4fiQJcNLx5eRJDM/fIzk?=
 =?us-ascii?Q?ECvDS2rsaVXELaRhmLVFXrR/lBMeSSmuqpNKtC6aaHKxa5QIFoxJ5iauOzgj?=
 =?us-ascii?Q?swPJ/JY8wOgqmTG7xMiYJq/4zeVHs8dLVROkdwjfUL5Kntly0nYMKEr66Jtn?=
 =?us-ascii?Q?D3+BYdLT5AryfMH4knONIEIuiyPO1jvQwDVyiWuROF8ly4aXg05GiG6EafoP?=
 =?us-ascii?Q?gVKiH5Pv52GL4wGXinN5n/p94Mo6PlFUuglmwIi1L1wm/8MiFSXqUAcZ+hbR?=
 =?us-ascii?Q?0PXfeCzCSVZBTyRzG5+MVnd2yYz7dkf7oT8k5ss9HaRltOP+B9Q6eRarCwxH?=
 =?us-ascii?Q?4E0ChMu0ZCIFTCw6LnPNZNxqnjhSxaX3poWrybiLWnlJl0M2Sn2Hp0j/QSuZ?=
 =?us-ascii?Q?n2WDM1uOstphlsQM22HMid5noqfnC0sbpEC5muRrkU6lEECkEzI8k2oa4o+S?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b5488c-71dc-47cc-8815-08da9cebdb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 22:43:24.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGL+Vg5sWoUdKU7rAMlRQoHfxy0p/TMvvrjmDsBEipwlfX0b20+Y1k1N5WKCB6B2vt8EmCCOEtVFMUNwVEiq7sQnmk3w/L0retYkrF4L+10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, Septe=
mber 22, 2022 3:39 PM
>=20
> From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Monday, Septe=
mber
> 19, 2022 3:05 PM
> >
> > pci_ids.h already defines PCI_VENDOR_ID_MICROSOFT, and is included via
> > linux/pci.h. Use the define instead of the magic number.
> >
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3c833ea..f2efb74 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2052,7 +2052,7 @@ struct hv_device *vmbus_device_create(const guid_=
t
> *type,
> >  	child_device_obj->channel =3D channel;
> >  	guid_copy(&child_device_obj->dev_type, type);
> >  	guid_copy(&child_device_obj->dev_instance, instance);
> > -	child_device_obj->vendor_id =3D 0x1414; /* MSFT vendor ID */
> > +	child_device_obj->vendor_id =3D PCI_VENDOR_ID_MICROSOFT;
> >
> >  	return child_device_obj;
> >  }
> > --
> > 1.8.3.1
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Actually, a nit:  The short commit message should start with "Drivers: hv:"=
 or
"Drivers: hv: vmbus:".  Check the commit history on vmbus_drv.c and you'll
see the standard usage.

Michael

