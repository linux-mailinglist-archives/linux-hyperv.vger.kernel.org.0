Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785841498D6
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgAZFAK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:00:10 -0500
Received: from mail-eopbgr1310131.outbound.protection.outlook.com ([40.107.131.131]:28589
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgAZFAH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyoYV7/84vGWtAkYk1ohDejJnXg2ywrmnjAC9tnn15c+PeUeXpDCwgeo1K8+c/deb4F0HgxI14GvJmHyBoiGzc/mtoHXYyF6eJqexkrGs4QqlLw6nccmtdR1sLs+8mGuf9KNLoGY6X/jBHF7jL/hsdLA58WY+LBFdW1B9mNVgJTkKjPkgS2hLd44hkMMexhdBNieCEeymixVGY4JXDyXnz4iXJp8xfDlLFajkvQeSTTCOmZiq3DM3v7oWKDaShPVDdvxfsF68S7No95LLghlZfeaO7MgsldLr2qWndBfRCwjDkHjbBDPaqVH+uA7XcM8YSm/RIgu7NX/KFWkDEfWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gIppsv+h6xuMsdbMJR6rhGTGE1/87sAqwwQltrlfRc=;
 b=Rd3POhZKS+xKV8t7xp0oedbMfeHUn5HkPdi9vmVi9o/tYPUr8l+OJH+ccJJ2TmTiGuCs9OyVQfM36Yzf8uu3e3HWDytP/qX5NkJR6AVK+/rzeHWJUX8Kbqn+LW1+RDjMmRRuadrd0JlH2GfKldDfwN2m7gnnsTa4cXSkBv3hNUhux+RIO0t4YKB1PXGIVCJNu3JI9VQb566BCOAUc8DgSRjdcigA9nAjOYzt2LHewYyQQUXeAlG/PrQondtOzZb/+JwL/3uClwDZmBvR62YOgcJTScpOGCEsjs3oMRapmrRwINsPE01NjjXzfDlc7GeIzadQyuFQVdOP0YvOxrCJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gIppsv+h6xuMsdbMJR6rhGTGE1/87sAqwwQltrlfRc=;
 b=BEAuLhn4YAhFjOtqnssKkSbpbWPypJYCS+bKAHu9ROP+k5OX3UlEsXmMBArQUx7ayH+Bj89TJCEd/MhyMNyPq7VAToutpmu/pnDzqFLn08ZaPot8GnkPWS/12x8toMlAHIV44Ee2yHH3aplY000T63pbFzjR7xTokviT6C/YNag=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.0; Sun, 26 Jan 2020 04:59:32 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2707.003; Sun, 26 Jan 2020
 04:59:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v3 1/4] Tools: hv: Reopen the devices if read() or write()
 returns errors
Thread-Topic: [PATCH v3 1/4] Tools: hv: Reopen the devices if read() or
 write() returns errors
Thread-Index: AQHV07lVd95yjtgTiE+JQQ3vMAq0wKf8XnwAgAAEEhA=
Date:   Sun, 26 Jan 2020 04:59:31 +0000
Message-ID: <HK0P153MB014854B3EA48F86C722F1011BF080@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
 <1579982036-121722-2-git-send-email-decui@microsoft.com>
 <MW2PR2101MB105256D6229F97FC16DC4735D7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB105256D6229F97FC16DC4735D7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T04:49:13.6387629Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=022339bc-bb50-4127-8274-d3106c3df480;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:67:1cd4:d237:9171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 542210cd-da45-4596-582c-08d7a21c880c
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0259E82C6114898EC889FF09BF080@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(8676002)(8990500004)(66556008)(81166006)(55016002)(4744005)(5660300002)(110136005)(66946007)(76116006)(9686003)(478600001)(8936002)(64756008)(66476007)(186003)(316002)(66446008)(10290500003)(86362001)(7696005)(71200400001)(6506007)(33656002)(81156014)(2906002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AE7MLD+O3Fq9sldYJgfjC2Q4Vi1upypcuJqjjOp+JZtx0TtwVy5SdHxIN9ElhWhl6vvlJ7b6JmqH8jj5XhX2p8+faqli+X9AiEhKa5gC19fGQBD4eSBA+2ibOCroiWFSmHXxYkAfc7JL+Dm92MERl8I4ugUezEY7caYF5JzcSoB0diJAgpq3kfQb4kA6fmAmVRaKTRJ1C+VA59pjPasApU6NoIBu7MXByYkMdvuX3x5MkREkXr8tL/cV/0XS2sxJtjw6c8JukoysOKEaW7LmKxL4MK6BqUh8mcvUo1wsqcAh9ucd7+GRDpYz7WzkKOHIdRI1/7hRs5WRk7XtgOZAQvGWsU8S++RKsJaibluo569iV8Z49oSQ91+36LLo2vNpAjLOKXDy4RG+43adgqBAjGJJNokIRjChAmQ+MWVQSpZp2Ij9IVmdaUn7iuCdf7tn
x-ms-exchange-antispam-messagedata: ur1OYpE15CBt8DlzaZMNu/LFtdoPcc8kbjbSV6hFPMOfIUalMvf3q4fiANjDO1IC98WefdM9prk/GV6SBNVsncIhdHaume8MKA+02lez0f9c/Ho2LmOkbCKRTjGtELqFwUSHE4elsisp1IovaSYLttprNmGTyYo3qhHiOqPyU7N1Ieh5/I/osDc/MBXdBEwLBwi1/Czn9zTVQPbbA4crhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542210cd-da45-4596-582c-08d7a21c880c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:59:31.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWpW0PfMD5GYx3mZ3nMDACFfO2FjPqk9598dCBGKYwgtOW7Ee7buHyWmsQmnen+EyBQyP8mI7R2b3EMS7748ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Saturday, January 25, 2020 8:49 PM
> > +reopen_fcopy_fd:
> > +	/* Remove any possible partially-copied file on error */
> > +	hv_copy_cancel();
>=20
> Since you have removed the calls to close(fcopy_fd) after a
> pread() or pwrite() failure that were in v2 of the patch, I was
> expecting to see
>=20
> 	if (fcopy_fd !=3D -1)
> 		close(fcopy_fd)

I missed this... Thanks for catching it!
=20
> here, like you've done with the kvp and vss code.  And
> remember to initialize fcopy_fd to -1. :-)
>=20
> Michael

Will do it in v4.

Thanks,
-- Dexuan
