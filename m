Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B422F8F14D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2019 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfHOQzU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Aug 2019 12:55:20 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:24289
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbfHOQzT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Aug 2019 12:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=angqzg1s6nZAuBrThzo2NkKkY3SQr1qptZwk9SoOxmaDegFiq9lRSVLxKh4mZwT+dLNQtwgMzSN3tP6kLpsAmiKvM9NwvPTi1N7HhfHXRQZ7uyUmX3VIfCcrUbcPXNUIR3MsBOFa6p2D+CEjsSyKwPUh33UtERjsEOSGBDeRlQDn3IILlgvcaz61LV5ufUBcCzbBFWov7HkEk9IBeclitpC8UhKATGyz0xbRlzxkIYgUSl01IrG6zrJdOvGCzaCa1F7vZEd2vEhZnUgZSWl0iRtIHNIisGnSU5VJJ4QIfRUhygj8RQSAHpqWUAC/+MNhq1tNfKFmqu5FcrsH+Ik5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hn/GNKXWLC73UqjSyp7QkpR+PNpzVPjedT3Be9zAL4=;
 b=USWo7DBWQRMRunsMOFQjK4tWMbv9JHQutaetmNhhNPbx9m67SM/mxuTb4eECuWz1MsBBEufop1f0JHk/TS1Ygvle/PyMj9f5JCCjST9x0to2nYLfiHKLe7p4m6Utbuv8w7GFwvl1ur78/vxaqYlJtjVpv31YWvma9PbMeWhOLKPI9kxJBZTZ/zmSqGsMEc0COqEMECrH72q6B68n9nJOst3QZ1kbfMxkvpXQjnBsJ93FOQ5uvg0w+Mmq6Yf9mkpYQsedRwAAlvjyFj0tPBhzI1SobEo0x/6rAdNajJOd1BKDO9CJ5jRxnBZcDLDqzxSfjhjsq/O4afoZYQs++lwxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hn/GNKXWLC73UqjSyp7QkpR+PNpzVPjedT3Be9zAL4=;
 b=ZYZv0xZEv/AkA/6GBPtH0E871JR1S5ThEQan/xtBI0lPm1NRg8mKLAuOBhMeeAP348mUeu3qZfyFeidknXoH+VLY0iVyZ59ZEH4sBNJ83W11oxX1AjEGRMzoXAkL6TYcOdEixHy4du5UMCZsbS6nDCIoFgnjtfKppicMcFKbP7Q=
Received: from BYAPR21MB1336.namprd21.prod.outlook.com (20.179.60.210) by
 BYAPR21MB1320.namprd21.prod.outlook.com (20.179.60.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.9; Thu, 15 Aug 2019 16:55:15 +0000
Received: from BYAPR21MB1336.namprd21.prod.outlook.com
 ([fe80::75ae:360d:ad16:4c78]) by BYAPR21MB1336.namprd21.prod.outlook.com
 ([fe80::75ae:360d:ad16:4c78%4]) with mapi id 15.20.2199.004; Thu, 15 Aug 2019
 16:55:15 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v5,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVUrg+xNhbQy4qc0m3irmViCOzpab8YpOAgAAI7yA=
Date:   Thu, 15 Aug 2019 16:55:15 +0000
Message-ID: <BYAPR21MB13369B7B03B3CB7760D7D79ECAAC0@BYAPR21MB1336.namprd21.prod.outlook.com>
References: <1565797908-5970-1-git-send-email-haiyangz@microsoft.com>
 <20190815160908.GA29157@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190815160908.GA29157@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-15T16:55:13.0391290Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=005d11c6-810f-41a8-a018-9ffd855ca5f1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9822cd2f-6d51-42af-2475-08d721a15855
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1320;
x-ms-traffictypediagnostic: BYAPR21MB1320:|BYAPR21MB1320:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB132089F66C488CB458834712CAAC0@BYAPR21MB1320.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(13464003)(189003)(199004)(81166006)(81156014)(8936002)(5660300002)(8676002)(10290500003)(8990500004)(229853002)(86362001)(14454004)(26005)(54906003)(99286004)(186003)(53546011)(478600001)(6916009)(6506007)(102836004)(33656002)(7696005)(52536014)(76176011)(11346002)(446003)(486006)(476003)(316002)(3846002)(4326008)(25786009)(22452003)(256004)(6436002)(74316002)(6116002)(14444005)(9686003)(2906002)(66476007)(64756008)(66446008)(55016002)(66946007)(66556008)(6246003)(76116006)(53936002)(10090500001)(66066001)(305945005)(71190400001)(71200400001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1320;H:BYAPR21MB1336.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hgdvHWcLgD4VW1Hf6LRgEkkwZJ23IfODET95nun+aP6GxBHa4RYJx/nCETfKCO/MY92zwk28vIUFVhm/LcinwRFB3CERNAxIOcCBP5WxH4welfcx+y6Ft3YZX3QorPARFNKyqBwHsSDTxnc501Ow8kuAhdVF129Xc4yN+jV8vt0sgc78m3M4LAahCvtINd+NxE5sOF0hQOhlOuCceQiE1OHUvfpGYHuyBLUCkPMbIGsgU3A2O+j8P/1capHWL1ScaAZCWzDG8Z5z54ZuaxOyYvKlQWmd02+VH/NUut/iqQf4oigyZPWI86YW836Y35/iPF8LTwBZTvJRLnDfGvG0laj6NCHuxZhvzjVAWWbMATNxJByLKfjy3uO/OALZ0uIYSRSmKLHgiTT0UrCzRePEpDaSZBzFGrxELxrMVfzWlKk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9822cd2f-6d51-42af-2475-08d721a15855
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 16:55:15.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJBJnE73JERSQNvzcy/Ljz76RUPTAxIOCMVWrt/uDsxkQbWF2WUjWYmfHwWkeeOXXAbTnOOAmylNyPsOyfqk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1320
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, August 15, 2019 12:11 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5,1/2] PCI: hv: Detect and fix Hyper-V PCI domain
> number collision
>=20
> On Wed, Aug 14, 2019 at 03:52:15PM +0000, Haiyang Zhang wrote:
> > Currently in Azure cloud, for passthrough devices, the host sets the de=
vice
> > instance ID's bytes 8 - 15 to a value derived from the host HWID, which=
 is
> > the same on all devices in a VM. So, the device instance ID's bytes 8 a=
nd 9
> > provided by the host are no longer unique. This affects all Azure hosts
> > since last year, and can cause device passthrough to VMs to fail becaus=
e
>=20
> Bjorn already asked, can you be a bit more specific than "since last
> year" here please ?
>=20
> It would be useful to understand when/how this became an issue.
The host change happens around July 2018. The Azure roll out takes
multi weeks, so there is no specific date. I will include the Month
Year in the log.

>=20
> > the bytes 8 and 9 are used as PCI domain number. Collision of domain
> > numbers will cause the second device with the same domain number fail t=
o
> > load.
> >
> > In the cases of collision, we will detect and find another number that =
is
> > not in use.
> >
> > Suggested-by: Michael Kelley <mikelley@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Acked-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 92
> +++++++++++++++++++++++++++++++------
> >  1 file changed, 79 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-
> hyperv.c
> > index 40b6254..31b8fd5 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2510,6 +2510,48 @@ static void put_hvpcibus(struct
> hv_pcibus_device *hbus)
> >  		complete(&hbus->remove_event);
> >  }
> >
> > +#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> > +static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> > +
> > +/*
> > + * PCI domain number 0 is used by emulated devices on Gen1 VMs, so
> define 0
> > + * as invalid for passthrough PCI devices of this driver.
> > + */
> > +#define HVPCI_DOM_INVALID 0
> > +
> > +/**
> > + * hv_get_dom_num() - Get a valid PCI domain number
> > + * Check if the PCI domain number is in use, and return another number=
 if
> > + * it is in use.
> > + *
> > + * @dom: Requested domain number
> > + *
> > + * return: domain number on success, HVPCI_DOM_INVALID on failure
> > + */
> > +static u16 hv_get_dom_num(u16 dom)
> > +{
> > +	unsigned int i;
>=20
> > +
> > +	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
> > +		return dom;
> > +
> > +	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> > +		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
> > +			return i;
> > +	}
>=20
> Don't you need locking around code reading/updating hvpci_dom_map ?

If the bit changes after for_each_clear_bit() considers it as a "clear bit"=
 - the
test_and_set_bit() does test&set in an atomic operation - the return value
will be 1 instead of 0. Then the loop will continue to the next clear bit, =
until
the test_and_set_bit() is successful. So no locking is necessary here.

Thanks,
- Haiyang

