Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2465D1A2974
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgDHTme (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Apr 2020 15:42:34 -0400
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:36615
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729090AbgDHTme (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 15:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlJA5Jl1/G7gLP7WEp1qBLdmW5DRDjc9NnSCfXcDamQkCGNHPlsnNcQcYJaCae3mdrGyJt6zfOjf3wej2B2XGvTvvNOlU2Uolj+pZsTNdC5xQoz/FkwXVoON3F7hQdMEhS9l0XXVLQ0z2qf7OgW9zlJpDHV+ma6HVkkCeulEriOcpjG4tGKuwGGmeRsKJ1/3Vg46qYaTfzAuvooQHuLnoqcEgYZYZkhojbNG2FkKKMQoi5z8KrTJf+HfAht6VvfiLYjOBzPJcrRBxW20JmliJZmjYw+3j919oZos6jl6uDUA77nTXrD3ew/mlD+4HN35vy31v+QUZu9+xRJW7qniOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdeKSAM3vTx65pJX8H3SHBfSgA/3yRVA7crIXWDpNkA=;
 b=JOY+mlIIyNIrFpj5WdzkLp9EEePVuoE9p1cnyxP/ieaHt/6fhFL8rCa51us25tCx3P7cWjDUzdBQJDfy+iZZRFdESXtp9ETHkGj3f0COiVbvD2erPKoyuB1QoL7Lfn6CiOKndh/aSHby5F9MSDJd6aD9QEG5S7zazVjnJJbswBvGVcZ5unFA1gojG1a4J2OTW0//zhskj8Z7A+4SGhq8wZp4F0oLtcWMGUuwyi8Vq4sfoVq2bzvyOkuZxbRDBgms9UqjvleMFEz6kVPQpMA7/V9Fhzi+M4U62qK8xzsLK/RkBdKOEFIR01gFguOtDz4W6AdSkJQgfrsaYJn6JwiHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdeKSAM3vTx65pJX8H3SHBfSgA/3yRVA7crIXWDpNkA=;
 b=MCFkqAr2N2i9vt4WrDW4df45HtfPf44X42f2FhTW33ZU09F3HLevydsA4jcIwW3bgpNlWRCAw5qbjOuruw1uh47AYZRdihxJhGSqMtv/U3SbHrvzOQbed2n5+R/YK7dVrqVPdVetVMi6zfnJmhmjYh4PUtNUcXXNiTfAkRFjq10=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0193.APCP153.PROD.OUTLOOK.COM (52.133.212.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.4; Wed, 8 Apr 2020 19:42:28 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.009; Wed, 8 Apr 2020
 19:42:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
Thread-Topic: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
Thread-Index: AQHWDb0CzRPAkatwXES7XuIgEFDFbKhvenBAgAAgogCAAALaEA==
Date:   Wed, 8 Apr 2020 19:42:27 +0000
Message-ID: <HK0P153MB0273FCBBEF151A3B3A4AB7F6BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1586296907-53744-1-git-send-email-decui@microsoft.com>
 <877dyq2d4p.fsf@vitty.brq.redhat.com>
 <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <87v9m9233b.fsf@vitty.brq.redhat.com>
In-Reply-To: <87v9m9233b.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-08T19:42:26.1558811Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e7928239-b5ff-4f4d-86a6-a849f7e5c7ff;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:25f2:87c1:762f:53ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5404c3d7-5789-47b4-53a2-08d7dbf4f886
x-ms-traffictypediagnostic: HK0P153MB0193:|HK0P153MB0193:|HK0P153MB0193:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0193A53F54B83CF121CBC699BFC00@HK0P153MB0193.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(8990500004)(76116006)(71200400001)(66556008)(66446008)(64756008)(33656002)(66946007)(66476007)(7696005)(9686003)(6916009)(53546011)(6506007)(55016002)(10290500003)(5660300002)(186003)(81156014)(54906003)(52536014)(4326008)(81166007)(478600001)(86362001)(107886003)(8936002)(316002)(2906002)(82950400001)(8676002)(82960400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTboEo50wrWjysTtuLnanPZDsmDD9V8sxIkhv79i2JBLjK63DyeQPTdZhqEXho9kemV/KDRFrDRVWdrcW4mIpuB2R4R1zjqNWm8gpZYLFKvTvqz1rkeU7Z0xmVPJU7ZsWA5QF93kklvVKRIRFNvaByRY0Y1NKVWd6yGD/zeHpXTjMXARBA07qTadZdi6bY7inDFL+nOdJMzkUh0tTNmFUaPH/wEhXy/EgHCqIF9p3I/e+lBkwhrItwPhrVoj1aKWj97U1AtqZuLsvx/agvSfiCCE4Wr2QxQqrEQwffirT1FwFxl4ghRQnIgQafDEdXXyVxEHUXV6dM2zez+x5g1Vl8aUfUeS65qx2/1TqbTPd1dDrD/tN0TMv19cSJq4y0U4PKYifSeB7d2uT7E3jaWlWJlV3B2rs2dO7LeyS/NsWFGfq2jNldFVCdLLlWVUlwei
x-ms-exchange-antispam-messagedata: vInF+FwQ3ZXIFqHI4zlI7ffPUxZm8LVlLNCG8qNmwHeUBAk0lHAG9YN6gJZWsxwqJxzdDCLf7V3hW3oz0ABB4Da+f6o9IinFbEa6sDee5IzGbsgoV+qY/oOuOVNROM9OKRzRf1vJbjqWG5Pqk1SDLRAZYxjLCXmTa+/LV9bunHXZafw5wodoNsW3y/FGQI1pX9+QlqIAaQ0xV4Ry33t/zQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5404c3d7-5789-47b4-53a2-08d7dbf4f886
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 19:42:27.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NPhuoGu2UWKCilf8vF/v0bSaGn1bM1rRrZg8YoK9vV6jZJ8O57Yd5Rgu85lmdnJ7BB8tvVB7Jneyd0LZ6fyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0193
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Wednesday, April 8, 2020 12:24 PM
> To: Dexuan Cui <decui@microsoft.com>
> > ...
> > This should be doable but IMO this is not a very trivial
> > effort, and I'm trying to avoid it since IMO Suspend-to-idle is not rea=
lly
> > useful in practice for a Linux VM on Hyper-V. :-)
>=20
> Well, to me it's equally (not) useful in all other cases :-) I think we
> should Cc: linux-pm@vger.kernel.org and someone will describe a real
> world usecase to educate us, we'll then see if there is any Hyper-V
> specifics.
Maybe I should support Suspend-to-idle, anyway. :-)

> >> In particular, why do we need to do
> >> anything when we are not hibernating?
> >
> > Are you suggesting hv_vmbus should not suspend the vmbus devices at all
> > in the case of Suspend-to-idle?
>=20
> That what we were doing prior to the hibernation series, right? AFAIU
Yes.

> suspend-to-idle is basically 'no processes are scheduled' mode but we
> don't really need to do anything with devices.
Got it. Let me try to make a patch to revert to the old behavior for=20
Suspend-to-idle.

Thanks,
-- Dexuan

