Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF7D7ED7
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfJOSYg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 14:24:36 -0400
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:2147
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729413AbfJOSYg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 14:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGAVUwyb2tVrlu6G+7gO+zj55neXrPBduJElEaNV9a4qXq5P/hL/XwF2ZbQuDSXou0LALn0ade1fHwf/FJfL4rGb+yVv9DkRwTOZM0iDzfM2zV5tvoz0JZ6WOYarXjBoxaQ71nNFZVkKSLH9qEJCftebSfyhPdmG7XsV4DG11KplierzE9s9tOQbO2ewvGa/b4Yd2UxFtTwsX0d6zy9cSlCxxhdUFH++Bpe28FY51ypMM6hrG1TJ3FTBVRfik7PABuSohAuttMELhh7nH8aZ4pDO8bvCi9filV6l58VjwuzWPDOqkADEfCOvkzY+5wMgOChOjow5FQ5Dsx2cdyblWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd2llT3Qp4lZ5BmS98gs3COxOAMyB7+0LoSSOESVpzU=;
 b=Y1wzcbFCc63rszlNfaDg7GM0Uix+g0H6NRhnpdu+qKucWs16DoH0VOajcazOUJoTl08AMVr1+7rcixI9H+inUtOS+ezjYux0Ai/mGKw2JyZpPiBuI5LvWbMamr3pjsbvoYrLGl52zZ+GoYcEi8lLQ9ibDAMeMYP2WBm8Tp/BrbPa8pxJLJhkSEaw4LCaazIKqyMUS01ed0FlpOZkkTfmNsklU0BQm0kRrYa4UgYlfAs5jpljr7fK2Ps7OiBQS1QBHF0LdPEbm+W7WCsfMS58nVj08ih2lX9iauPFbwircw18qh6UpCQV/r2BdWllqO4/oXYNUVyvP4PwTjm9QvYW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd2llT3Qp4lZ5BmS98gs3COxOAMyB7+0LoSSOESVpzU=;
 b=FBBoYEmd1CQu7C7BiGPdaaUS7uQrnbcoHlUnx10kb/haIfAETtJzPGe7KtCbvv7jzXjSiS84mKoILhQQwcmxv9PgeiDZhI7cgpo8lPpkc4ythCQgQLuB3uqTyvxFf3Zc2T8VdCljn9RbnP33Qfde6Fcd7qF84sxSWMm2I+uxGQQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.4; Tue, 15 Oct 2019 18:24:24 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2367.014; Tue, 15 Oct 2019
 18:24:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v3 0/7] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Topic: [PATCH v3 0/7] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Index: AQHVguM6ZVHMkNMmDkOKmQf0ukqcFKdcBU3Q
Date:   Tue, 15 Oct 2019 18:24:23 +0000
Message-ID: <PU1P153MB016959BF4A437FF0C21F5834BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191014230016.240912-1-helgaas@kernel.org>
In-Reply-To: <20191014230016.240912-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-15T18:24:20.0381088Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d4b57d94-55c8-4218-8e7c-3944c26391d1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:48c8:deb3:fcc5:6e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd83419-38a0-4c55-4296-08d7519ce7d8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0155:|PU1P153MB0155:|PU1P153MB0155:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0155DD281E2C23C834359E43BF930@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(11346002)(486006)(7416002)(74316002)(8936002)(14454004)(81166006)(81156014)(4744005)(2906002)(476003)(33656002)(46003)(478600001)(446003)(4326008)(229853002)(5660300002)(305945005)(10290500003)(6916009)(316002)(6436002)(52536014)(7736002)(8990500004)(55016002)(14444005)(22452003)(6116002)(256004)(7696005)(9686003)(99286004)(10090500001)(86362001)(71200400001)(71190400001)(6506007)(102836004)(54906003)(8676002)(6246003)(186003)(66446008)(64756008)(66476007)(66946007)(76116006)(66556008)(25786009)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YYTjbhBJ/Khdf1Ro3TdHnTBYFxgA2QrOmLUas5TSSCga1//0zvTULlN67qGVZYUq3j+UGkP5xS1FfHReBa7fVo1ac7BD/fMwQ6UZsU2UvaH7CeQC8GwcQoA5vcSoKsHpyYFjj9A6rRRFZUu2n9tjEOmPshWvZOy9tr1DLAqfP2Wza4P5kvAD+xfIgm+t4Cna6ddYwGpLiQ2E5F132Dl96NmwwzbHpQqd0PTqk9WlXU82VU0lYTvfer01prUf1TuHN9GGoUSOQnXfWi3iZ0+dLszcF+zN4E+DFJhfGDriMMfTBTLYEEHG5Z6sLrHG9+XuLSmuJSv8DdLksAR9bt526X8mVn0mG6WcxP/l8N5YlORf51RTujbNh+MxuDAniAWCbypKrHWsVfllzewgaq3p8wsymN53FxyV+SqcHqXDxE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd83419-38a0-4c55-4296-08d7519ce7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 18:24:23.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTc+MWOHj3UqP4GQujQuhDZ8o9KpVNgeZwUHx+zX+NEyf36ttTsd7lbjw6wZa1uyVOPQapCqeqgsY4oHvGRGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, October 14, 2019 4:00 PM
>  ...
>=20
> Dexuan, the important thing here is the first patch, which is your [1],
> which I modified by doing pci_restore_state() as well as setting to D0:
>=20
>   pci_set_power_state(pci_dev, PCI_D0);
>   pci_restore_state(pci_dev);
>=20
> I'm proposing some more patches on top.  None are relevant to the problem
> you're solving; they're just minor doc and other updates in the same area=
.
>=20
> Rafael, if you have a chance to look at these, I'd appreciate it.  I trie=
d
> to make the doc match the code, but I'm no PM expert.
=20
Thank you very much, Bjorn! The patchset looks good to me.

Thanks,
-- Dexuan
