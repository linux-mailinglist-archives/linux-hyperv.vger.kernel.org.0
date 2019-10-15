Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1675D773A
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfJONPe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 09:15:34 -0400
Received: from mail-eopbgr730116.outbound.protection.outlook.com ([40.107.73.116]:8298
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729551AbfJONPe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 09:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3+RN66aLjdbSpPZ77jqUFh5JcgES0kFoL+z9KNLfVeFjwsFxvA2BFN37GXbBePybu/dAYEYpwYO1R94Is99Vzg0wu3eWkgvMLEJx10DGznKupOIE5oNGrIkPiIgo2Eva8HqtRdzi7+QtjQZvMQ/cBcc0OS5qsHdbgShAyRyTtQNVKYtfM9Fa81JMtn309AQfR0G4bqIVJsRq5XYeLw4UxOIXoadba3bJToyLR+izz0wbXumjNg/+NHMsPKs3zwroYAaCiA+EMWFU2DcqeNonNHMOSgvE9e8rCYAthhYkmoATIxAmmGS9eZ94uV+bysYIeWE99/mNZFFMwJkir8smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0q9oSQ9mKdD7JK1RBjH5CRcUw88eXkNwR+5yxXns5X0=;
 b=P1hFEk+93m5f4PPRX1cEpwh7PdOeJk7Hd9eDDXsZSo4Z+ocWE8so1QScgw+2Qel+77t5Tps7zPdip0jRBBUm6JfCEdSNiZDQvtKks3OWs8UUCp4z2ovmjyjmsHFiPCP0nrgkax0A3NBAJsp863hL9Yg8CPkiDQtJMiZ6iyuE+G53gosANxt560ToPKXwymKjKwxMHE0LANg2bXqtRg71pfI+aEEtVH95vU74+1XWWK21jvCuDfvODV6SQPlCEZhTxz1kijuNp5CSF9fyULbrV6rmL53l7Mq9dnGh6VYw4E23haA5JqjxCMzeS3paEMRpqpp+swPco/MV6qm5Rc9Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0q9oSQ9mKdD7JK1RBjH5CRcUw88eXkNwR+5yxXns5X0=;
 b=KFxhxdFcJO79ghq1doD12JerOg8FXeCBXOhhIQCCIP2nNR66FGnkHq8dvKegRXO3XDZoDOnipOBoZV2RU3PkW3ovJ98BFXgZ9DCTn9WSxCN+nf9CucIBHvjWW8A42gVDmBwsQ0Z0u+Evyc9dQm6ejQdm3h8/puYo1PY1zEudJU4=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0745.namprd21.prod.outlook.com (10.173.172.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Tue, 15 Oct 2019 13:15:32 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e%11]) with mapi id 15.20.2347.023; Tue, 15 Oct
 2019 13:15:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        vkuznets <vkuznets@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v3 3/3] Drivers: hv: vmbus: Add module parameter to cap
 the VMBus version
Thread-Topic: [PATCH v3 3/3] Drivers: hv: vmbus: Add module parameter to cap
 the VMBus version
Thread-Index: AQHVg05RRjxab/oj70GFm8EYihbfkadbrdtw
Date:   Tue, 15 Oct 2019 13:15:32 +0000
Message-ID: <DM5PR21MB013736C1459A260E9D6E9A31D7930@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
 <20191015114646.15354-4-parri.andrea@gmail.com>
In-Reply-To: <20191015114646.15354-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-15T13:15:30.3848646Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9ba475e1-64fd-4334-bb09-77238936d2a6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee2c6c4-a5f3-4370-22de-08d75171c205
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0745:|DM5PR21MB0745:|DM5PR21MB0745:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0745F41CD7B0FE79AC3C54C9D7930@DM5PR21MB0745.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(55016002)(52536014)(8936002)(6506007)(2906002)(229853002)(11346002)(5660300002)(446003)(4744005)(2201001)(81166006)(81156014)(305945005)(6246003)(86362001)(7736002)(66066001)(186003)(74316002)(26005)(71190400001)(71200400001)(4326008)(6116002)(8676002)(6436002)(3846002)(102836004)(316002)(10090500001)(256004)(9686003)(2501003)(33656002)(22452003)(10290500003)(478600001)(110136005)(54906003)(76116006)(66946007)(25786009)(486006)(66446008)(64756008)(66556008)(66476007)(476003)(7696005)(99286004)(76176011)(14454004)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0745;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xmugq4WkcaUOB+4U4fGtd1je8iSFmsVj6X8gr2je+wFgxwk9XJ6EqgOKyhWm1OxEbo/Sfnrb04Nuq1zyp2RXV7ChxsAXSbjFu9nhveZGyLgYzDuFp7fI4lE94UAA+uyerUA6mNKzxWPBGQu0aH6btylMILgPsbsUqpOS3h3h9QiTjqV/fT5ivJYBZE+uH2WFz6d//jQU4OHOkcUE3hLDSHAvdK3ZLjF7PEpeBbOGnqbhVKZedEdEa+927DkVXerygTZ4PmssWfHv5PKvTEybdunHBd6opEWm/qAVSR484FtyXVZFXXZCZk9FjgRm6Zi5rK+FC6OmBw/cgMgOQwHrcJPUR7G2SCZy3/4pUmX8b2ZuGrma5r5VMVv1Y5s1d9e0u0c8E0VEeU+ucXzChlejUJNG7FvbKRSdrekK39RW3dg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee2c6c4-a5f3-4370-22de-08d75171c205
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:15:32.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykhgr2nvum5PPAXH7P6qTTYbtwxbNn42E5/djfTYpScsS/Z6jGwnQIj4LRG2SD0IMhZVdiEnSOhQzgz8LFD58yMje7FGgTXpKh4QZnXV2Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0745
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2019=
 4:47 AM
>=20
> Currently, Linux guests negotiate the VMBus version with Hyper-V
> and use the highest available VMBus version they can connect to.
> This has some drawbacks: by using the highest available version,
> certain code paths are never executed and can not be tested when
> the guest runs on the newest host.
>=20
> Add the module parameter "max_version", to upper-bound the VMBus
> versions guests can negotiate.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
