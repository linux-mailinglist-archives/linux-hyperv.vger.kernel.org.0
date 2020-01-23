Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5214630D
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 09:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgAWILJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 03:11:09 -0500
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:49570
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgAWILJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 03:11:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAlCvPNXNEdSkWa5ogY9W0XLPUrw8I3k4C0EOFSSoY7I627d8H4x4R0pSuVE1M0ewpXTgTn+2yzC/DVa1Gw313yjm+FpHSgrZKYUoDADc8chLf8l0H9kp4V9EbIrYX2CDogBKHZiDkbdMc52vSHqr4VU7wyzUvH6yRGztB0V9kKZn6KbMbz7pg2QiMEqFwfIfyACSr7IepH+B/Mwn9oLEsnZava7Q7Djjpo1UMgByVXehpq7/perz5IMWU4GZ/fLIoRHiFBakbNCUTxx9Q+BJ78hHNusjrZuOapE58YXs6b5M6Uz1W49Eau+njHr6t2o/iE1qVcRSKzxVoKjXVFlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INN/eSNwJq5C5izLOIlkSH2mG7pFM38FRENTqtfnEGs=;
 b=L/8tV7+2OSw/CbVfTvL47kP58EyOM/D/x3N7aAMERyI5vzCQwzYqdOnO77abp1+Wx4TWNXFLiOuUxaSfLPcF0C/W6tdfU1/tv9p+tRqx6OLQQmCGhioFaWXcfSYlX3SV4F0XCYYfXbcN0nF4rTxceS/98kxGMkKFO8Hb9l06OY51VxOH7gyKLLlpjtQy7+n9s2xiyz/z2OI53j4UsQVlp5NqcMf0QsNY0mgP9E3dilzc3RsAopVmFkFGOcJoNx+Ys8yOrr5xGG6p4MmAizMPupHpk5sq23qcNHVoXkkbVve51D1oK4gk2Hoczdps2qAwFRcMYp7ztnM9eKQdkMC9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INN/eSNwJq5C5izLOIlkSH2mG7pFM38FRENTqtfnEGs=;
 b=NlZXc4O0+CYMF2QJS8J0yV711gSaXR+iXCpClxrRjhtQrGcXU/bpUO7f4ilYSqYI8KhBNuWNJ6owZz9lJwaW5FbuwydDwGhCBihZafuYOhENZvcVGsaI84KSqcfvfpRUkl6hdpS3DtZ/dDhXFEBvBgEjGJbFHN1X13z6ZAuckXI=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Thu, 23 Jan 2020 08:10:57 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2686.008; Thu, 23 Jan 2020
 08:10:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] Tools: hv: Reopen the devices if read() or write()
 returns errors
Thread-Topic: [PATCH v2 1/4] Tools: hv: Reopen the devices if read() or
 write() returns errors
Thread-Index: AdXJ2us37YcsbC5xRo+dztn1Sn9t5wHZtLIwABsCvxA=
Date:   Thu, 23 Jan 2020 08:10:57 +0000
Message-ID: <HK0P153MB01483385D79219EBCDE4037DBF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB01486C8C746F8936450C4CE1BF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <DM5PR2101MB1047BBD2C8C7B382D77EF981D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1047BBD2C8C7B382D77EF981D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:30:19.3913829Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=445a901f-62e5-4b70-a3d7-9d004f5f39df;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:21c4:4274:62b5:126b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58512725-4c30-4117-ebeb-08d79fdbc6af
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB02595EC530C24426A44641D9BF0F0@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(86362001)(10290500003)(110136005)(478600001)(186003)(8990500004)(81156014)(33656002)(81166006)(8936002)(8676002)(2906002)(7696005)(6506007)(5660300002)(71200400001)(66446008)(66556008)(55016002)(76116006)(66946007)(52536014)(64756008)(66476007)(316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJZ84fHigs1jgyBabPJjkZCGiQpO31hirCMpv15256H8GLhSwLrt9rvR2GZ1aPd6c4ENO3KBJPr+xaXQdWEJJVURYpFBZsYyB9bE+etAxSqmy9EJreoe6nirjU1uTUJe5jyhvgGDqpKh9KnnRK3/f8hzQ1hTqAuwRQ7Jah+xkU6Ml5WclvMJFt7rBLP3WxJQD0fP5zKVThfulp9tz5iUtFkxiNARwS/HNIVXsu95m5o8TOR2N21nnpzLIhSb+A7jgsH2IpwOnrrrqkcIouMr/B5xGhYJrEdj5oRp0p8ZwPWEypnUnRlEywyRlBDOH3VUa+veEc/u44mUchZahzW4f6OIH39LYYoSdBR+sbADGJ3YRIfDxhDD3D8HP5/oVo6Fdbu9jMeSu5tLHpKN7ssPS+q5cfm3/t/my82oAShf9MXggZTY2DVghQnCIPPlb+Hx
x-ms-exchange-antispam-messagedata: ES8sZ7dLmP+yky5hNE0hJYuuUNVy7I9u/tF0XoofSuSrrBJRkwnTS3BP/37XNNrjeGb6nF2cAT6IRyESPl0FKYaAvbhNAFChhsm1laFjjBe3ptZ4Agk4GmrWoRY2yjWAxGb9Uw8YI7DSXd6Vf2Mtwy6EDEV57nfp7Sf3J8HC6QEHVrcQ1MNuZk5k6EgihsyQ7UNVXUe3ZeU3G2GRoQP4Dg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58512725-4c30-4117-ebeb-08d79fdbc6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 08:10:57.2198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /suoJYbqG2YX59nMGPtsOavLyS8u2HGtz5wNEd0gtyHddZo4ilLO3qt6eFj9hZj9KJWImS2RtiyZjY16uMaWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, January 22, 2020 8:54 AM
> > ...
> > @@ -111,12 +113,16 @@ static int hv_copy_data(struct hv_do_fcopy
> *cpmsg)
> >  static int hv_copy_finished(void)
> >  {
> >  	close(target_fd);
> > +	target_fd =3D -1;
> > +	memset(target_fname, 0, sizeof(target_fname));
>=20
> I'm not completely clear on why target_fd and target_fname need to
> be reset.  Could you add a comment with an explanation?  Also,

After checking the code again, now I think we indeed don't need
"target_fd =3D -1;", but we need to reset target_fname because the kernel
hv_utils hibernation patch fakes a CANCEL_FCOPY message upon suspend,
and later when the VM resumes back the hv_fcopy_daemon may need
to handle the message by calling hv_copy_cancel(), which tries to remove
a file specified by target_fname.=20

If some file was copied successfully before suspend, currently=20
hv_copy_finished() doesn't reset target_fname; so after resume, when
the daemon handles the faked CANCEL_FCOPY message, hv_copy_cancel()
removes the file unexpectedly.

This patch resets target_fname in hv_copy_finished() to avoid the described
issue.=20

In case a file is not fully copied before suspend (which means hv_copy_fini=
shed()
is not called), we'd better also reset taret_fname hv_copy_cancel(), since =
we'd
better make sure we only try to remove the file once, when we suspend/resum=
e
multiple times.

I'll add a comment in the next version of the patch.

> since target_fname is a null terminated string, it seems like
> target_fname[0] =3D 0 would be sufficient vs. zero'ing all 4096 bytes
> (PATH_MAX).

I agree. Will use this better method.

> > +reopen_fcopy_fd:
> > +	hv_copy_cancel();
> > +	in_handshake =3D 1;
> >  	fcopy_fd =3D open("/dev/vmbus/hv_fcopy", O_RDWR);
> >
> >  	if (fcopy_fd < 0) {
> > @@ -196,7 +205,8 @@ int main(int argc, char *argv[])
> >  		len =3D pread(fcopy_fd, &buffer, sizeof(buffer), 0);
> >  		if (len < 0) {
> >  			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
> > -			exit(EXIT_FAILURE);
> > +			close(fcopy_fd);
> > +			goto reopen_fcopy_fd;
>=20
> In this case and all similar cases in this patch, there may be some risk
> of getting stuck in a tight loop doing reopens if things are broken
> in some strange and bizarre way.   Having an absolute limit on the
> number of reopens is potentially too restrictive as it could limit the
> number of times a VM could be hibernated and resumed.  Ideally
> there could a simple rate limit on the reopens -- if it happens too frequ=
ently,
> go ahead and exit like the current code does.  Thoughts?

If there is a bug, IMO it's better to get stuck in a tight loop, so the use=
r
can notice it more quickly by the "top" command. :-)

With the patch, the daemon can get stuck in the loop only when the daemon
successfully reopens the dev file and registers itself to the kernel, but f=
ails
to handle one of the messages. IMO the chance is pretty small, and if that
happens, there must be a bug in the hv_utils driver we need to fix, so, aga=
in,
IMO it's better to make the bug more noticeable by the tight loop. :-)

If the daemon fails to reopen the dev file or fails to register it to the k=
ernel,
the daemon still calls exit().

> >  static int vss_do_freeze(char *dir, unsigned int cmd)
> >  {
> > @@ -155,8 +157,11 @@ static int vss_operate(int operation)
> >  			continue;
> >  		}
> >  		error |=3D vss_do_freeze(ent->mnt_dir, cmd);
> > -		if (error && operation =3D=3D VSS_OP_FREEZE)
> > -			goto err;
> > +		if (operation =3D=3D VSS_OP_FREEZE) {
> > +			if (error)
> > +				goto err;
> > +			fs_frozen =3D true;
> > +		}
> >  	}
> >
> >  	endmntent(mounts);
>=20
> Shortly after the above code, there's code specifically to
> do the root filesystem last.  It has the same error test as above,
> and it seems like it should also be setting fs_frozen =3D true if
> it is successful.

Yes, I missed that. Will add code for that.
=20
> > @@ -167,6 +172,9 @@ static int vss_operate(int operation)
> >  			goto err;
> >  	}
> >
> > +	if (operation =3D=3D VSS_OP_THAW && !error)
> > +		fs_frozen =3D false;
> > +
> >  	goto out;
> >  err:
> >  	save_errno =3D errno;
> > @@ -175,6 +183,7 @@ static int vss_operate(int operation)
> >  		endmntent(mounts);
> >  	}
> >  	vss_operate(VSS_OP_THAW);
> > +	fs_frozen =3D false;
> >  	/* Call syslog after we thaw all filesystems */
> >  	if (ent)
> >  		syslog(LOG_ERR, "FREEZE of %s failed; error:%d %s",
> > @@ -202,7 +211,7 @@ int main(int argc, char *argv[])
> >  	int	op;
> >  	struct hv_vss_msg vss_msg[1];
> >  	int daemonize =3D 1, long_index =3D 0, opt;
> > -	int in_handshake =3D 1;
> > +	int in_handshake;
> >  	__u32 kernel_modver;
> >
> >  	static struct option long_options[] =3D {
> > @@ -232,6 +241,10 @@ int main(int argc, char *argv[])
> >  	openlog("Hyper-V VSS", 0, LOG_USER);
> >  	syslog(LOG_INFO, "VSS starting; pid is:%d", getpid());
> >
> > +reopen_vss_fd:
> > +	if (fs_frozen)
> > +		vss_operate(VSS_OP_THAW);
>=20
> Need to set fs_frozen =3D false after the above statement?

fs_frozen is set to false in vss_operate(), but there is a chance
vss_operate() may fail due to some reason, and hence fs_frozen may
remain to be true. I'll add the below code:

@@ -242,8 +242,14 @@ int main(int argc, char *argv[])
        syslog(LOG_INFO, "VSS starting; pid is:%d", getpid());

 reopen_vss_fd:
-       if (fs_frozen)
-               vss_operate(VSS_OP_THAW);
+       if (fs_frozen) {
+               if (vss_operate(VSS_OP_THAW) || fs_frozen) {
+                       syslog(LOG_ERR, "failed to thaw file system: err=3D=
%d",
+                              errno);
+                       exit(EXIT_FAILURE);
+               }
+       }
+
        in_handshake =3D 1;
        vss_fd =3D open("/dev/vmbus/hv_vss", O_RDWR);

Thanks,
-- Dexuan
