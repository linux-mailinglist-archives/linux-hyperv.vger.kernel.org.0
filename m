Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449331B34A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDVBsi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 21:48:38 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:30720
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgDVBsh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 21:48:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnCKwS/znCg3HKXDVc2aidWl+qts2X8KZNnTqBuWcdOzUuOrK29pJqm43IuGB+99/qQUv0Bv8F64fMYL0sPwAp7P6Ii6IxghsdO8CrIV/UwfXhrjLd/ieaFuDv575J52lRDQESLsrBCkeh0tQ5g7Z3GGycKScMX+3BwkB0sBv4MOrKkIdMq77yVLHluSuOgdwJTSAWqms8+i19CNmTtiEoengG/HaTWvyX0vLm5PEtC3YkxVSoBGVBdxQqFCbsRbUbWKMS5ObVlstfMsG8R/xBzYzVXAmK2cukgQG0i7TvLLjXjad7XSKgv+aT11nSItVpkCE1bxVK5YE/N0xXsrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Trh7+kj0MFxRS/3SjryRd7oFAAvY9Ul8HamoF8EBY=;
 b=gDDx+T/Zdel6jUUs1V+GCq+/dEwgaSLHEVJ8y7guRPKJvPM+rGrVFjcBo/OEfHVlqFbkbDFihHCNkmpCNiGch4NRNh2lG+S2fCibCHmE4RUrCVWJCGKdXcJ4XK+3MYDW4zPF5e8VKOFxii5xTYLPdch4wRZou+C0sJx3BvLUs198SxLQ9TaY9ROoOVvCEWHdHa6H6yDOIPCF2FeuNESEqm52+BEDMZgLes2frpVMyowcv1Wh0HAOZoy9gkd2rK+v7e2rbXjbYV1mQcV0RENrGR5lBKxf1c9VRVbaGUa031PqT5WaHhVFry4i94D98OfL/UiFiOKLXdLacExwVGyGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Trh7+kj0MFxRS/3SjryRd7oFAAvY9Ul8HamoF8EBY=;
 b=P6mqKLJ+NoaGYFwikHT49EuK7kauSwyxztrNBp/WD6Jz/P3g1uZc31Bocop2SAkjS8Xx+zKg2ycmnszydH4hsfqU/pMZBnHh1Aie7Ap76azUXRD/A7Xo5IsPzDzgI7txSBJ0QnhuSsTsWDqPwGjsu92o/BA5347NLDVYm56K6Mk=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0276.APCP153.PROD.OUTLOOK.COM (52.132.236.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.2; Wed, 22 Apr 2020 01:48:25 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.006; Wed, 22 Apr 2020
 01:48:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGEVb6DFeJK2tFE2eFTHRpRyDH6iEXZcA
Date:   Wed, 22 Apr 2020 01:48:25 +0000
Message-ID: <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
In-Reply-To: <20200422012814.GB299948@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-22T01:48:22.7841881Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1b1cb9c-45ca-4119-bd15-cbd9e08eec1a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:a0d3:b235:bb01:7ca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5044851-dd0e-48e4-f499-08d7e65f3f5d
x-ms-traffictypediagnostic: HK0P153MB0276:|HK0P153MB0276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0276BC464B233A8187C27D02BFD20@HK0P153MB0276.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(186003)(82960400001)(82950400001)(107886003)(2906002)(66446008)(76116006)(7696005)(64756008)(66556008)(66476007)(33656002)(7416002)(316002)(6916009)(8936002)(478600001)(10290500003)(86362001)(8676002)(81156014)(54906003)(9686003)(6506007)(5660300002)(53546011)(55016002)(52536014)(66946007)(8990500004)(71200400001)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqRzhB+iCj+piFaC4TPZLtO7+Rw0Z2hlKI1Hh2z/cCDocxsgBY80+cx1/hUgf0ojWx5GY6XPFNGQp90GI01Yw9u8cdBQRBFDo+goIVkPNGHQH5pJlt+1jdAZ+KcQ/jyuzcUcaDuqWeutcNEoa1jqU+F+4jYn1vVEvuq/9xGUGbxxd7iLoe3h+QddE/B2S+QgjtnmWcavwPdO7CeqkJ88VJUbARoiiE6avwf/5mrEmoC8ZCqzCXTgm1rR5zvM3N4PiE7N4ZMggvUDaVYXUWn3EI6f1h1Acl4f/GVaQ1ulNB6SP5H8Tn+0NllIcN1L17WGdj8gIBOAz4Cj/r8VbTNWptDkx3Hxqq/S+TxMkuMD/KzaokqNNg3wmfZb8Ldam2vGy9wRf07hAPVF3eb9Av482YRCztGBO09kV02kmzarpCmPvNe6GTIxaR1wu3pZstvk
x-ms-exchange-antispam-messagedata: cRZSigelK1iVcBOgxyKPQAIpJfUbfwMmWojoDKao/T3m9fUMefB5UE22RC31UNhZHH1sWKYYrixsQGXIxwg1heQBxBwuXSYz9NQ/4nrSEkPzp3gSdSesdp+F5bd2O/vUQ+620E831uN6u8NfuDDMcpRMN59phv1Ox0Hcp2fziO7MR2ulGpCj3m2D0Nc+8f6pmBV/T+bb2agZFO7hNF4c8WvjVazgLr+WR8cPHnQPDRjsOzfe4KY+t142jVf72bhHnR0qkJkWRrPLO6dObuoekQoCVpMyZ4su1xcRts5igsQf/SyW8W6mmhxST54cDkYiPU36kUOtCrrrQgcev/nsutg7JUT6qlGFF56gxnQbZZ2dxhkq5ZEPjYOKV8XjBaxptZLUEIMrhYGIidjb8VIc3Gaqx7W2RsLFrs1D3LkDM9untKFQqvrbz4GZ4sOL+dn0U7tKvNiofM71EiMksrjRQmyfy+g8/x2sWMyXd0eqkXr/3cLZcX3Atbmai5qMvUZ6ZaBSsilz1mZ9qzBgqwYNFwLRh1/Z4AwgEpsTKPOz5sKeNjYH8+l1kf/CiWbud8gfSIiea2zi3OAuumJtrxAqQnPqp4VMbN99hzv+GggTSBQg9SKxiXrQxF0BYcgoFLEJ5VpBeLlfNCOGKv1r/AHe/WYqdirZtnJn09AYPOpGv6MSWs669CweeIijEa/SQiqE7qUpxuBEZDPPDT8lJOLhaV8xsefEJhWXBKF1OB81WaHuO7KTzwZrjjAPhAiTHedTwmkca9xsYHxDxQkpKXF6XvDiUkxMl1A+/lSilg9vIGcmhYviH9HJEWejp+A4LwM4yGuuqUvCrFdfqWWl8LWw5ORDdGPtFuEv3r3cX0jHeV4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5044851-dd0e-48e4-f499-08d7e65f3f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 01:48:25.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHUwvdJhlRLcLISeLqF93MiaE/PV399qpkRhHx9S3ER4pTQn0Cwx8RAyAeicw/vbAegSXGCk3rCgadT/D5koOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0276
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Tuesday, April 21, 2020 6:28 PM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Tue, Apr 21, 2020 at 05:17:24PM -0700, Dexuan Cui wrote:
> > During hibernation, the sdevs are suspended automatically in
> > drivers/scsi/scsi_pm.c before storvsc_suspend(), so after
> > storvsc_suspend(), there is no disk I/O from the file systems, but ther=
e
> > can still be disk I/O from the kernel space, e.g. disk_check_events() -=
>
> > sr_block_check_events() -> cdrom_check_events() can still submit I/O
> > to the storvsc driver, which causes a paic of NULL pointer dereference,
> > since storvsc has closed the vmbus channel in storvsc_suspend(): refer
> > to the below links for more info:
> >
> > Fix the panic by blocking/unblocking all the I/O queues properly.
> >
> > Note: this patch depends on another patch "scsi: core: Allow the state
> > change from SDEV_QUIESCE to SDEV_BLOCK" (refer to the second link
> above).
> >
> > Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index fb41636519ee..fd51d2f03778 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1948,6 +1948,11 @@ static int storvsc_suspend(struct hv_device
> *hv_dev)
> >  	struct storvsc_device *stor_device =3D hv_get_drvdata(hv_dev);
> >  	struct Scsi_Host *host =3D stor_device->host;
> >  	struct hv_host_device *host_dev =3D shost_priv(host);
> > +	int ret;
> > +
> > +	ret =3D scsi_host_block(host);
> > +	if (ret)
> > +		return ret;
> >
> >  	storvsc_wait_to_drain(stor_device);
> >
> > @@ -1968,10 +1973,15 @@ static int storvsc_suspend(struct hv_device
> *hv_dev)
> >
> >  static int storvsc_resume(struct hv_device *hv_dev)
> >  {
> > +	struct storvsc_device *stor_device =3D hv_get_drvdata(hv_dev);
> > +	struct Scsi_Host *host =3D stor_device->host;
> >  	int ret;
> >
> >  	ret =3D storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
> >  				     hv_dev_is_fc(hv_dev));
> > +	if (!ret)
> > +		ret =3D scsi_host_unblock(host, SDEV_RUNNING);
> > +
> >  	return ret;
> >  }
>=20
> scsi_host_block() is actually too heavy for just avoiding
> scsi internal command, which can be done simply by one atomic
> variable.
>=20
> Not mention scsi_host_block() is implemented too clumsy because
> nr_luns * synchronize_rcu() are required in scsi_host_block(),
> which should have been optimized to just one.
>=20
> Also scsi_device_quiesce() is heavy too, still takes 2
> synchronize_rcu() for one LUN.
>=20
> That is said SCSI suspend may take (3 * nr_luns) sysnchronize_rcu() in
> case that the HBA's suspend handler needs scsi_host_block().
>=20
> Thanks,
> Ming

When we're in storvsc_suspend(), all the userspace processes have been
frozen and all the file systems have been flushed, and there should not
be too much I/O from the kernel space, so IMO scsi_host_block() should be
pretty fast here.=20

Of cource, any performance improvement to the scsi_host_block() API is
still great. :-)

Thanks,
-- Dexuan
