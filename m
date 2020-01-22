Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D94145A4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2020 17:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVQx6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jan 2020 11:53:58 -0500
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com ([40.107.92.95]:44129
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgAVQx5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jan 2020 11:53:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbV6N2z2VhOICJlFwEvMuXGqy0RhppP3IcOfbU/dwrn1ybOXdIkWyd39Uwi2c1dE6A/H6asyCCOiIcUqx1XW/WBlCDFws5N/fiTBIOsBqVlHr1MLb5Dl3k0aBFQuGyiz7+FS2Nnon1Zoutv2i2XYZk59LDJs1nIedYaWf6EEJkucNW/Zjcoib+sJxGZl9Q8p3NKu3olNrSpmCWcYw64LcJ8cBm292mo4K3xGBIIPJu4QFQz840KjOAfy8UbTzFBqTO0CQgxFAAntp5/ZkgM4R9tO6Rp5Eah2bmRcNX5fmRhXyeeei19UAz32Vpsrhdeagz2wT+VcbEMdPmSW0vrEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iqz75Bme6DwkBqgVN/zqY1szkOJoPdsyZcNZE/w0/c=;
 b=e8KPMnRV8Z2nv3NsG4kwklGTCoxweW43dS5dnIL9fBprqIUfQ/pMroQ1nFGvI0KXjXQlRdTIGLp/qoylp/mMn8ezsN7E0dgI+fOGucWNeKDXCA59AvgfibVOvEOOTgFR6q4be4jMKrTzIJ+rs1fPHuYJZJP8sRx4bkbKMbmulAIeplncJ4uXYda8Yffn9HyAIcoNX60VjXvJ+B6KCwUXJlJ6AdThZWddFsR4hk1fEXpgOOsfO1o+6UiMYduJ2o8fry0GZA76V3f7q7jbP9/e2bHbVd2TIyGgkfzfFXojIV7w9TBHFDDtiYWzFqBEPXRS/POVG1IKxPuNO4J4MR+zJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iqz75Bme6DwkBqgVN/zqY1szkOJoPdsyZcNZE/w0/c=;
 b=FAxsV8R8NL0DC9UzrJqXVuvM0SSKFZZLY9ok5dyWi73H8ahENGjhWEEfy/LMkreSbEfjlMfVKQDUR3uOmXrHGekYumXNKnST+RhNH/eja4u97hAKdEs+t7vVfhWgjki5AxQz+HgZCyQtd/W8Xc7BEVo+0fzgl3dOu96D7ncX+sM=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) by
 DM5PR2101MB0869.namprd21.prod.outlook.com (10.167.110.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.10; Wed, 22 Jan 2020 16:53:50 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43%5]) with mapi id 15.20.2686.008; Wed, 22 Jan 2020
 16:53:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AdXJ2us37YcsbC5xRo+dztn1Sn9t5wHZtLIw
Date:   Wed, 22 Jan 2020 16:53:49 +0000
Message-ID: <DM5PR2101MB1047BBD2C8C7B382D77EF981D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <HK0P153MB01486C8C746F8936450C4CE1BF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB01486C8C746F8936450C4CE1BF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba8874e3-e824-41de-6d90-08d79f5ba7cb
x-ms-traffictypediagnostic: DM5PR2101MB0869:|DM5PR2101MB0869:|DM5PR2101MB0869:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0869C8BA63EBD6BB551E6377D70C0@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(2906002)(7696005)(186003)(76116006)(8676002)(55016002)(5660300002)(66476007)(86362001)(66946007)(66556008)(26005)(66446008)(6506007)(8936002)(8990500004)(64756008)(33656002)(52536014)(9686003)(478600001)(110136005)(316002)(81166006)(71200400001)(81156014)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1047.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBWvXp7iVhR2e2vM0kEdKx93jesGtuekuZJbMajavy2jtuiS+xk1fWwrp0aClpZs/iVUvYKwtqeYIoebgE1m49kM5/ztwd3FoJruOkPfOeM2NIlgvi1tfzq69HwP7XOXofyUGGZCWf3OKuPfU/8K1aco96tSpWL5l42yL6dS3h/Uo4iCsKAGZ1A1fwqnAKRtGA9bxdOVgoZ088A5pLWfW4MJ/zdD5ESJUoj8+fL+NhCxaTIwnTLcPIs5QbMI8o1D/tpHNdyEF9WYqzufyyhqXefe8gpKXI44zABc2Ug+hvtkBCFZiaMBDztAOhSnA2bzK5OiHYyUl76FttSnn/Uz7Ds1GkQvNvRwthN3ZCvm6xbUgCGBxyIal5xjP4F4WfX5tXkXcQU56Ec74P2ez3HzvFbnExvGZhajjCHaP6fQ7V99JhpgwinWPXn+w6BdtLzm
x-ms-exchange-antispam-messagedata: kVftN7tHehFcl1ZH5aXVCIjnt80nNwRRvyDm+pvuu62LmBw3uR4GIFgbAOJEZhW8IHryyYeqQGeD80l1whMICvTRWAHvPUxvE0G9yyHATNE4CNz0yueFuxSyXSevxABZInNYd16FgAAmIHFFNZeWcw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8874e3-e824-41de-6d90-08d79f5ba7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 16:53:49.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VnrRcJ6SswlhWwScmwifTjaEhZGxybGmVD2N8gozdZkAeGRqG4O0Uq0ggkdQU9yAzFtXZlGbmt8fPVkOgHES4kxHmUNtekCAgbhzmHHwKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 12, 2020 10:30=
 PM
>=20
> The state machine in the hv_utils driver can run out of order in some
> corner cases, e.g. if the kvp daemon doesn't call write() fast enough
> due to some reason, kvp_timeout_func() can run first and move the state
> to HVUTIL_READY; next, when kvp_on_msg() is called it returns -EINVAL
> since kvp_transaction.state is smaller than HVUTIL_USERSPACE_REQ; later,
> the daemon's write() gets an error -EINVAL, and the daemon will exit().
>=20
> We can reproduce the issue by sending a SIGSTOP signal to the daemon, wai=
t
> for 1 minute, and send a SIGCONT signal to the daemon: the daemon will
> exit() quickly.
>=20
> We can fix the issue by forcing a reset of the device (which means the
> daemon can close() and open() the device again) and doing extra necessary
> clean-up.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  tools/hv/hv_fcopy_daemon.c | 19 +++++++++++++++----
>  tools/hv/hv_kvp_daemon.c   | 25 ++++++++++++++-----------
>  tools/hv/hv_vss_daemon.c   | 25 +++++++++++++++++++------
>  3 files changed, 48 insertions(+), 21 deletions(-)
>=20
> diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
> index aea2d91ab364..a78a5292589b 100644
> --- a/tools/hv/hv_fcopy_daemon.c
> +++ b/tools/hv/hv_fcopy_daemon.c
> @@ -21,7 +21,7 @@
>  #include <fcntl.h>
>  #include <getopt.h>
>=20
> -static int target_fd;
> +static int target_fd =3D -1;
>  static char target_fname[PATH_MAX];
>  static unsigned long long filesize;
>=20
> @@ -80,6 +80,8 @@ static int hv_start_fcopy(struct hv_start_fcopy *smsg)
>=20
>  	error =3D 0;
>  done:
> +	if (error)
> +		memset(target_fname, 0, sizeof(target_fname));
>  	return error;
>  }
>=20
> @@ -111,12 +113,16 @@ static int hv_copy_data(struct hv_do_fcopy *cpmsg)
>  static int hv_copy_finished(void)
>  {
>  	close(target_fd);
> +	target_fd =3D -1;
> +	memset(target_fname, 0, sizeof(target_fname));

I'm not completely clear on why target_fd and target_fname need to
be reset.  Could you add a comment with an explanation?  Also,
since target_fname is a null terminated string, it seems like
target_fname[0] =3D 0 would be sufficient vs. zero'ing all 4096 bytes
(PATH_MAX).

>  	return 0;
>  }
>  static int hv_copy_cancel(void)
>  {
>  	close(target_fd);
> +	target_fd =3D -1;
>  	unlink(target_fname);
> +	memset(target_fname, 0, sizeof(target_fname));
>  	return 0;
>=20
>  }
> @@ -141,7 +147,7 @@ int main(int argc, char *argv[])
>  		struct hv_do_fcopy copy;
>  		__u32 kernel_modver;
>  	} buffer =3D { };
> -	int in_handshake =3D 1;
> +	int in_handshake;
>=20
>  	static struct option long_options[] =3D {
>  		{"help",	no_argument,	   0,  'h' },
> @@ -170,6 +176,9 @@ int main(int argc, char *argv[])
>  	openlog("HV_FCOPY", 0, LOG_USER);
>  	syslog(LOG_INFO, "starting; pid is:%d", getpid());
>=20
> +reopen_fcopy_fd:
> +	hv_copy_cancel();
> +	in_handshake =3D 1;
>  	fcopy_fd =3D open("/dev/vmbus/hv_fcopy", O_RDWR);
>=20
>  	if (fcopy_fd < 0) {
> @@ -196,7 +205,8 @@ int main(int argc, char *argv[])
>  		len =3D pread(fcopy_fd, &buffer, sizeof(buffer), 0);
>  		if (len < 0) {
>  			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
> -			exit(EXIT_FAILURE);
> +			close(fcopy_fd);
> +			goto reopen_fcopy_fd;

In this case and all similar cases in this patch, there may be some risk
of getting stuck in a tight loop doing reopens if things are broken
in some strange and bizarre way.   Having an absolute limit on the
number of reopens is potentially too restrictive as it could limit the
number of times a VM could be hibernated and resumed.  Ideally
there could a simple rate limit on the reopens -- if it happens too frequen=
tly,
go ahead and exit like the current code does.  Thoughts?

>  		}
>=20
>  		if (in_handshake) {
> @@ -233,7 +243,8 @@ int main(int argc, char *argv[])
>=20
>  		if (pwrite(fcopy_fd, &error, sizeof(int), 0) !=3D sizeof(int)) {
>  			syslog(LOG_ERR, "pwrite failed: %s", strerror(errno));
> -			exit(EXIT_FAILURE);
> +			close(fcopy_fd);
> +			goto reopen_fcopy_fd;
>  		}
>  	}
>  }
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index e9ef4ca6a655..3282d48c4487 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,7 +76,7 @@ enum {
>  	DNS
>  };
>=20
> -static int in_hand_shake =3D 1;
> +static int in_hand_shake;
>=20
>  static char *os_name =3D "";
>  static char *os_major =3D "";
> @@ -1400,14 +1400,6 @@ int main(int argc, char *argv[])
>  	openlog("KVP", 0, LOG_USER);
>  	syslog(LOG_INFO, "KVP starting; pid is:%d", getpid());
>=20
> -	kvp_fd =3D open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
> -
> -	if (kvp_fd < 0) {
> -		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
> -			errno, strerror(errno));
> -		exit(EXIT_FAILURE);
> -	}
> -
>  	/*
>  	 * Retrieve OS release information.
>  	 */
> @@ -1423,6 +1415,16 @@ int main(int argc, char *argv[])
>  		exit(EXIT_FAILURE);
>  	}
>=20
> +reopen_kvp_fd:
> +	in_hand_shake =3D 1;
> +	kvp_fd =3D open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
> +
> +	if (kvp_fd < 0) {
> +		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
> +		       errno, strerror(errno));
> +		exit(EXIT_FAILURE);
> +	}
> +
>  	/*
>  	 * Register ourselves with the kernel.
>  	 */
> @@ -1458,7 +1460,7 @@ int main(int argc, char *argv[])
>  			       errno, strerror(errno));
>=20
>  			close(kvp_fd);
> -			return EXIT_FAILURE;
> +			goto reopen_kvp_fd;
>  		}
>=20
>  		/*
> @@ -1623,7 +1625,8 @@ int main(int argc, char *argv[])
>  		if (len !=3D sizeof(struct hv_kvp_msg)) {
>  			syslog(LOG_ERR, "write failed; error: %d %s", errno,
>  			       strerror(errno));
> -			exit(EXIT_FAILURE);
> +			close(kvp_fd);
> +			goto reopen_kvp_fd;
>  		}
>  	}
>=20
> diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
> index 92902a88f671..e70fed66a5ae 100644
> --- a/tools/hv/hv_vss_daemon.c
> +++ b/tools/hv/hv_vss_daemon.c
> @@ -28,6 +28,8 @@
>  #include <stdbool.h>
>  #include <dirent.h>
>=20
> +static bool fs_frozen;
> +
>  /* Don't use syslog() in the function since that can cause write to disk=
 */
>  static int vss_do_freeze(char *dir, unsigned int cmd)
>  {
> @@ -155,8 +157,11 @@ static int vss_operate(int operation)
>  			continue;
>  		}
>  		error |=3D vss_do_freeze(ent->mnt_dir, cmd);
> -		if (error && operation =3D=3D VSS_OP_FREEZE)
> -			goto err;
> +		if (operation =3D=3D VSS_OP_FREEZE) {
> +			if (error)
> +				goto err;
> +			fs_frozen =3D true;
> +		}
>  	}
>=20
>  	endmntent(mounts);

Shortly after the above code, there's code specifically to
do the root filesystem last.  It has the same error test as above,
and it seems like it should also be setting fs_frozen =3D true if
it is successful.

> @@ -167,6 +172,9 @@ static int vss_operate(int operation)
>  			goto err;
>  	}
>=20
> +	if (operation =3D=3D VSS_OP_THAW && !error)
> +		fs_frozen =3D false;
> +
>  	goto out;
>  err:
>  	save_errno =3D errno;
> @@ -175,6 +183,7 @@ static int vss_operate(int operation)
>  		endmntent(mounts);
>  	}
>  	vss_operate(VSS_OP_THAW);
> +	fs_frozen =3D false;
>  	/* Call syslog after we thaw all filesystems */
>  	if (ent)
>  		syslog(LOG_ERR, "FREEZE of %s failed; error:%d %s",
> @@ -202,7 +211,7 @@ int main(int argc, char *argv[])
>  	int	op;
>  	struct hv_vss_msg vss_msg[1];
>  	int daemonize =3D 1, long_index =3D 0, opt;
> -	int in_handshake =3D 1;
> +	int in_handshake;
>  	__u32 kernel_modver;
>=20
>  	static struct option long_options[] =3D {
> @@ -232,6 +241,10 @@ int main(int argc, char *argv[])
>  	openlog("Hyper-V VSS", 0, LOG_USER);
>  	syslog(LOG_INFO, "VSS starting; pid is:%d", getpid());
>=20
> +reopen_vss_fd:
> +	if (fs_frozen)
> +		vss_operate(VSS_OP_THAW);

Need to set fs_frozen =3D false after the above statement?

> +	in_handshake =3D 1;
>  	vss_fd =3D open("/dev/vmbus/hv_vss", O_RDWR);
>  	if (vss_fd < 0) {
>  		syslog(LOG_ERR, "open /dev/vmbus/hv_vss failed; error: %d %s",
> @@ -285,7 +298,7 @@ int main(int argc, char *argv[])
>  			syslog(LOG_ERR, "read failed; error:%d %s",
>  			       errno, strerror(errno));
>  			close(vss_fd);
> -			return EXIT_FAILURE;
> +			goto reopen_vss_fd;
>  		}
>=20
>  		op =3D vss_msg->vss_hdr.operation;
> @@ -318,8 +331,8 @@ int main(int argc, char *argv[])
>  			syslog(LOG_ERR, "write failed; error: %d %s", errno,
>  			       strerror(errno));
>=20
> -			if (op =3D=3D VSS_OP_FREEZE)
> -				vss_operate(VSS_OP_THAW);
> +			close(vss_fd);
> +			goto reopen_vss_fd;
>  		}
>  	}
>=20
> --
> 2.19.1

