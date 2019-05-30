Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545842E99A
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2019 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE3AFa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 May 2019 20:05:30 -0400
Received: from mail-eopbgr810128.outbound.protection.outlook.com ([40.107.81.128]:28768
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfE3AFa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 May 2019 20:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=nCmieT1j29s7eQqdSou2FSo6qkqTLcQy1O/2MiR9QwpOisWbvs1IdoLSWKnGRx1p8jBpX8Vvyq7JlZ8TqqmqzBdvwP6pt0yE+EKKcWwwKEEcUWDtEjPPYdthx/NLTFRaWGyLGxcDiaBTRaAQtvdd6YxreXjcqo24P07EQHpmc9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D77KhL2ThG/098EUK04aIGGQ3VCLkmVhzMfsbYPzKF4=;
 b=tqBC/XUOub1Am901EawfkkGFoomZ/tHEqBvsxpRtO8ASGxiOUtOWhcGbjsKoREtS3I15dYn1WcSe5NDKZtKbOdcsq5sOI3V/HNTDzXak+nl3utyov3FHF7cnB34FUJ+tb9c47yPtHhVB6hJ4zHoKNPcjdD+7IgDvyL+VDYKCPkE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D77KhL2ThG/098EUK04aIGGQ3VCLkmVhzMfsbYPzKF4=;
 b=EeT8qX2j2zU7HHuM5Yp2LiMpN6GBe/0OO5zxYNn5XKD3bTjFOooT02HLxCb+vvngkj20OBT1eNwCH8GyAOGW3TjQN3fmMdV97RNDeLkXqMO2WVOf580wQ1gNbOtcl4JIrwqZrr6A2TeewF9sM+tso2Y/HM4D+dA0LFOpQXqTmpQ=
Received: from BYAPR21MB1221.namprd21.prod.outlook.com (2603:10b6:a03:107::12)
 by BYAPR21MB1320.namprd21.prod.outlook.com (2603:10b6:a03:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.3; Thu, 30 May
 2019 00:05:26 +0000
Received: from BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b]) by BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b%7]) with mapi id 15.20.1943.015; Thu, 30 May 2019
 00:05:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Break out ISA independent parts
 of mshyperv.h
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Break out ISA independent parts
 of mshyperv.h
Thread-Index: AQHVFdIRA7mIiwIVVUaFxjQSrR2UTaaCPiqAgACK/FA=
Date:   Thu, 30 May 2019 00:05:25 +0000
Message-ID: <BYAPR21MB1221CD9AAEF9BCC6A5AF0C7AD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <1559101942-4232-1-git-send-email-mikelley@microsoft.com>
 <875zptmfp4.fsf@vitty.brq.redhat.com>
In-Reply-To: <875zptmfp4.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-30T00:05:23.1347754Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b7d8a73e-8c49-45d0-a683-aac6ecefe01c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36b5764b-7fef-497f-cff5-08d6e4928490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR21MB1320;
x-ms-traffictypediagnostic: BYAPR21MB1320:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1320740C29CC51BBD22A56E3D7180@BYAPR21MB1320.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(136003)(189003)(199004)(229853002)(8990500004)(7736002)(256004)(25786009)(74316002)(10090500001)(54906003)(33656002)(6116002)(14454004)(5660300002)(316002)(476003)(10290500003)(446003)(107886003)(6246003)(11346002)(22452003)(68736007)(8936002)(66066001)(53936002)(26005)(186003)(486006)(2906002)(71200400001)(71190400001)(3846002)(66556008)(66446008)(305945005)(76176011)(81166006)(4744005)(4326008)(73956011)(8676002)(81156014)(66476007)(86362001)(6436002)(64756008)(66946007)(99286004)(9686003)(6916009)(478600001)(55016002)(52536014)(102836004)(7696005)(76116006)(52396003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1320;H:BYAPR21MB1221.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z+wWC1qwlVMQO60kpvfTOQnX5OoEgVeYouafg/qaXSFFrudRn5yF3/ygxjb7v9HoyatZbhkEGUgUvM4wZMsFiVoYZHh7TaVDcNMy31mIqTNZMyztbZbhaLDTnu/rLxrY+ZVZgJzlg+VOHWeNlxklO6F9dB3MBqvbByY8D38woAFGWsopFWNvIP5NajJ8nZ2y0cuzVIbP3BHovGsT59YWWZViwCe5Vb4J6NXrR0BmH3XfwqxwByFccIsgJLwl2jdVmY39VSy0bDjNg5LY0U9E4Esict5cgc7ntkLd6XvTgRwhkiM6DL1eBNiBFml5LqpadLgSSxh2uWOUCy+xYQ5ECyllNjLEVngUMwlLkT/qlJG2Xsxm8yYyNd8vDqHb0czikd3cNU7DkZaYOP+BkTal67z4kKZ3kuRqLIkxJfgtZl8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b5764b-7fef-497f-cff5-08d6e4928490
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 00:05:25.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1320
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, May 29, 2019 =
8:41 AM
> >  void __init hyperv_init(void);
>=20
> I would actually expect to see hyperv_init() on all architectures so it
> can probably go to 'generic' too.
>=20

Actually not.  The declaration is not needed on all architectures.   On ARM=
64,
hyperv_init() and ms_hyperv_init_platform() are folded into one routine, an=
d
it's not externally referenced.  So the declaration isn't needed.  The hype=
rvisor
initialization approach is fairly different on ARM64.

[....]
>=20
> This seems a little bit too much, in particular, I think we don't need
>=20
>  #include <linux/interrupt.h>
>  #include <linux/clocksource.h>
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>=20
> we'll need 'struct pt_regs' definition but I'd suggest we use
>=20
>  #include <linux/ptrace.h>
>=20
> or even
>=20
>  #include <asm/ptrace.h>
>=20

Agreed.  I'll spin a v2 with this cleaned up.

Michael
