Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AD4BE846
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfIYWZJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 18:25:09 -0400
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:24192
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbfIYWZJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 18:25:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKnZjPdbHTrnzW5IXdsXGMlOIvQIxe3l/+xEGXrXM9VetrgNUgbNzHBAzYBTr0gBSnpvb+d6EoB7jWaAO6Z7g7q15STbRinw7wIkgKwZ71/1rwNNWzATEHjVNDld1r51kJmoVfqhjuCq50/jNLmU8FrsrNCb9cKEVSuzYyEgYWaMYb0AR3yLaGs7CK0vD6yVKN6QD8xi9xWH9RyR7HUcO2ao/A1E2Io8bVAUGpDii3SN2lpKjk8OW8AZp/Ln5Fi57eiKz2EejvevZBpAvg4+a9mP+i7adn9kxZGXc04OkQmVK78h/fsvcxDGCgJOrMuvU3FAYwRnWIpZ19iUPcza/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTIBkjK6fEASPkqskDhT4WRfUjNIVAN7ETUURVEQEB4=;
 b=ZkzTL4b9YEIxDPrl1efHS3xwuLNTMIc3URHQLDuBtJCXksuzbrCkw5CQNpinVh5D7i1dG4bXBjISUc0ExcnmXggKeZcAp+cO9MQFtHHcxrhVb6Yo/hLTkxDGo8WAJWNPywV85BJ7XvSxCXEceQ60DfPK0/zuAlmhcpSvIJaXxySw/AffUFdveM07Od8WPfALuJiI4hvS2NbA5/vqxjw0ky7q6+bwsCpXU5pTUagfKvbWrnxr9rpukL1GwwEV8rBn4rOUCPULcedZUFlM5lN8S138XFlRru+5U04EVMYv1CdvltMYve+V1weX0ZhoOI1D+ZU9N/ajNplJBClgNQM30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTIBkjK6fEASPkqskDhT4WRfUjNIVAN7ETUURVEQEB4=;
 b=JYcMLiIv6cbE/TnC+wdOUZ1rLtwSGBnP5tA/ENGei75jTZIbuo0kmS2pD3N3CkqCtE4TJnsrc8GFLSbePOnSxosOPFCabu8WLJMU0sNNI3EiGu0DLipRcLjT2b9ISZVI2NV2rEm7LC7lq0aWcd6atjFa+tPO8IsAEAzrzx64yJU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.6; Wed, 25 Sep 2019 22:25:00 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 22:25:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Topic: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Index: AdVSPER5d22rbcvgTV28JV77HSffhgPsqanQBIAm+UA=
Date:   Wed, 25 Sep 2019 22:25:00 +0000
Message-ID: <PU1P153MB0169DECAA73E88F49B333CF7BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <KU1P153MB0166994305CF5B9CFA612AA7BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB0166994305CF5B9CFA612AA7BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-14T01:06:51.2322584Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab25360d-4a75-4436-9390-ec9b2f112f8b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04544e4f-460f-43a4-f0e8-08d74207346c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0122:|PU1P153MB0122:|PU1P153MB0122:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB012256E31D8A3A354DF29FAFBF870@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(54534003)(199004)(189003)(2906002)(66556008)(66476007)(478600001)(14444005)(74316002)(8990500004)(6116002)(8936002)(110136005)(14454004)(54906003)(6246003)(305945005)(7736002)(2201001)(4326008)(2501003)(22452003)(99286004)(64756008)(9686003)(7696005)(66446008)(66946007)(1511001)(6436002)(76176011)(229853002)(55016002)(76116006)(10090500001)(71200400001)(53546011)(33656002)(186003)(486006)(7416002)(52536014)(5660300002)(86362001)(46003)(25786009)(71190400001)(6506007)(81156014)(102836004)(8676002)(446003)(11346002)(81166006)(476003)(10290500003)(316002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULMBJjhKAXfatCJl/ceX66XYDL7Y8EXkTOO7KrUWokOR+QDUxe2Xld6oSSkCUIiPmx0W2Dzu2EOTc3G0cK75ea5v0yta+r9VCG6GvX7W43EazC13snU99QyfT1mnb46p3cPpxu6gjQSH8vVhkGMeFUaorY9Ali9R4JsBacyyaVXhA0Gylm5lcsrFe+aAGDVuLo8aJmOYR62gti1akZ9/1jrqST+fzxPWzBT6HF/B0W55+weolN+dFKU7xZdwndSFcjZJQxv30IboLhOBNJtbAR7ULzFU8/vGl3DlaV6Nbto11GFdGn6m6HDRoSjP0+EJ24Fl3zGvhxshOD/tNnZKiIi+HlwzvPwjmg7QHQ+h++cia78Y6c282borJ8vXM14vByqk6G86kHRqEK96sAn9TH3JamhiwR+1daF91eRanBs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04544e4f-460f-43a4-f0e8-08d74207346c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 22:25:00.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVMJ0CIDJ7PbkgAqJv2VK8I7xVeJEHglcxh3jVfLOddu4tDUTjBqzI58kxg4eNBFAFHK+35Re3LhXJ+kgsbStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Dexuan Cui
> Sent: Monday, September 2, 2019 5:35 PM
> To: lorenzo.pieralisi@arm.com; bhelgaas@google.com;
> linux-pci@vger.kernel.org
> [..snipped...]
> > ---
> >
> > changes in v2:
> > 	Updated the changelog with more details.
> >
> >  drivers/pci/pci-driver.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 36dbe960306b..27dfc68db9e7 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device
> *dev)
> >  			return error;
> >  	}
> >
> > -	if (pci_has_legacy_pm_support(pci_dev))
> > -		return pci_legacy_resume_early(dev);
> > -
> >  	/*
> >  	 * pci_restore_state() requires the device to be in D0 (because of MS=
I
> >  	 * restoration among other things), so force it into D0 in case the
> >  	 * driver's "freeze" callbacks put it into a low-power state directly=
.
> >  	 */
> >  	pci_set_power_state(pci_dev, PCI_D0);
> > +
> > +	if (pci_has_legacy_pm_support(pci_dev))
> > +		return pci_legacy_resume_early(dev);
> > +
> >  	pci_restore_state(pci_dev);
> >
> >  	if (drv && drv->pm && drv->pm->thaw_noirq)
> > --
>=20
> Hi, Lorenzo, Bjorn,
>=20
> Can you please take a look at the v2 ?
>=20
> -- Dexuan

Hi Lorenzo, Bjorn, and all,
It looks this patch has not been acked by anyone.

Should I resend it? There is no change since v2.

Thanks,
-- Dexuan
