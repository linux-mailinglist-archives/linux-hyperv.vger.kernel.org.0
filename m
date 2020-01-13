Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5599138BD2
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 07:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgAMGa1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 01:30:27 -0500
Received: from mail-eopbgr1300133.outbound.protection.outlook.com ([40.107.130.133]:62496
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732311AbgAMGa1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 01:30:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WePwmECX8UR7/GCLYGH/TdZKut/2XE6jE3Y7Y+Vuhs0+Uzlg67Go6qBE8cjnNKZxQOfqOeFMVbUyS61hDvlJ2lbvV5WtpTEtZ9+6mubcUBaCNwd/EGVSjHEFf9ok8BAX9gt3EcEeKh/HO13Z7pleFUMpIXj5JRzKS7L904ZHIqshHp2G6qsmHbsRknfvBsZOh+egE9u4MNEVH8YUrP9mZ+vHVMWfvDd1k6QSmmyua9RAQCIiWiA81WYYBbDlSPkOJ8nVfwHA8poz50zA+8MW6KQ1rmyvBaD6I8j7ZEiLrFqYhIKoa3uo/fpTSOv1a8TKlzehR4NVs/QHibld8PNYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2hastcoLbSiRGhqq21pVxA4HXN73Eiw2NX5vtqQWb0=;
 b=j0nGp8/pE/B3mXUxkU2CdpZujqWWrBJZIwIhUJTz/8MwY+WJcFEvsoZfc5vkdsdvOfmnXAeP/JCXYWfae46oW6uqakj6r5xnCuLQwmlYGRHlRJiIuar3/V+UfzFcsU7OjQGbrXUI5DifukY9FiFx99ueC2o5nde3iEMj/Y2pynvd3FbnIsTwEx0+vrmm2nyBT7h2CuLvUdCJg2Mitpn0HO9quM2ZbfZ9BB1+gAgXtrWVIyMUX48foLrp73ITGLQc89kI772rD5bLjoiIw73bzAtllB1fWgTlJ1Jd5xd4keFW8ciBsKX7xYWVAPGO1kyXEcp39gmJJtIWzCk/FOTHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2hastcoLbSiRGhqq21pVxA4HXN73Eiw2NX5vtqQWb0=;
 b=Kc5WWAjajYV4Z6GmA1KmbuZJJ+tONaPDRuwdCFhMsVNw3XwWA1iZG4EQc1p/sHjyYV2chNr9d+YtzjIGs0ZUMMFXWC7bUsxYqYUGHW1wCWCCJw51f+QNv2DoNgWT1ded2fo8yKDpzZfh7i8UMN/K5UWAwwTUyMEcPaFg6DJnGBM=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0324.APCP153.PROD.OUTLOOK.COM (52.132.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Mon, 13 Jan 2020 06:30:21 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 06:30:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] Tools: hv: Reopen the devices if read() or write()
 returns errors
Thread-Topic: [PATCH v2 1/4] Tools: hv: Reopen the devices if read() or
 write() returns errors
Thread-Index: AdXJ2us37YcsbC5xRo+dztn1Sn9t5w==
Date:   Mon, 13 Jan 2020 06:30:20 +0000
Message-ID: <HK0P153MB01486C8C746F8936450C4CE1BF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
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
x-originating-ip: [2001:4898:80e8:a:fa69:ae29:32b9:aa46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6c38c36-14a8-42c3-b3f8-08d797f210a3
x-ms-traffictypediagnostic: HK0P153MB0324:|HK0P153MB0324:|HK0P153MB0324:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0324A896A0E60168A1A655DDBF350@HK0P153MB0324.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(5660300002)(10290500003)(33656002)(186003)(7696005)(86362001)(2906002)(6506007)(52536014)(478600001)(81166006)(81156014)(110136005)(316002)(76116006)(8936002)(9686003)(64756008)(55016002)(8990500004)(66556008)(66476007)(66946007)(66446008)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0324;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0B6O0HXJWBMd+kPQO3Ne347l26ZZ6zSrxA/NIyCDUz2fT733bDNgAwKfxRmsiP7/yyCCTonZGG1zZzmUCp8/Vy0+6QiSuHwM/SKUc+uttV1lqinknFhE0+2gcz6wM7PFrJC01BUsJrAhSWZ+CQrU96RXes8F4vSh2/xaHgQAt6UoNbE1HjXaYhnUOL/MrSIzNEVLOcaWenl2yx9FgGoAi/DpdHsGEolh9FFGAVcQmo8wUFebRkw8xFWktTI/zKN1En4jR576e1n7aY3vJ5FHQCFRj+jmpWowrdngcEiwNtOVLeM9glNw+0yCL3+tuLcy9Vk7qlyCJWewB6CO/OrfAt0vHQYOQI1F0NpDARrsVpg9GzyhH+NVNL2bL/ZRZGZN85HU3Wdm6wY7fuQdV9Mw5bo7IbZve9FPfCMI5PGMHAg5jCLBYjedsJpImvehPvOh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c38c36-14a8-42c3-b3f8-08d797f210a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:30:20.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXOcl9tqageW0jJNUbR06IEmzW0H0KAW/q6o85g6hZkF1DWII6NIF8Ma8NsszuD2wlFdr4CqSVKTsIYjkJ16Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0324
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


The state machine in the hv_utils driver can run out of order in some
corner cases, e.g. if the kvp daemon doesn't call write() fast enough
due to some reason, kvp_timeout_func() can run first and move the state
to HVUTIL_READY; next, when kvp_on_msg() is called it returns -EINVAL
since kvp_transaction.state is smaller than HVUTIL_USERSPACE_REQ; later,
the daemon's write() gets an error -EINVAL, and the daemon will exit().

We can reproduce the issue by sending a SIGSTOP signal to the daemon, wait
for 1 minute, and send a SIGCONT signal to the daemon: the daemon will
exit() quickly.

We can fix the issue by forcing a reset of the device (which means the
daemon can close() and open() the device again) and doing extra necessary
clean-up.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 tools/hv/hv_fcopy_daemon.c | 19 +++++++++++++++----
 tools/hv/hv_kvp_daemon.c   | 25 ++++++++++++++-----------
 tools/hv/hv_vss_daemon.c   | 25 +++++++++++++++++++------
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index aea2d91ab364..a78a5292589b 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <getopt.h>
=20
-static int target_fd;
+static int target_fd =3D -1;
 static char target_fname[PATH_MAX];
 static unsigned long long filesize;
=20
@@ -80,6 +80,8 @@ static int hv_start_fcopy(struct hv_start_fcopy *smsg)
=20
 	error =3D 0;
 done:
+	if (error)
+		memset(target_fname, 0, sizeof(target_fname));
 	return error;
 }
=20
@@ -111,12 +113,16 @@ static int hv_copy_data(struct hv_do_fcopy *cpmsg)
 static int hv_copy_finished(void)
 {
 	close(target_fd);
+	target_fd =3D -1;
+	memset(target_fname, 0, sizeof(target_fname));
 	return 0;
 }
 static int hv_copy_cancel(void)
 {
 	close(target_fd);
+	target_fd =3D -1;
 	unlink(target_fname);
+	memset(target_fname, 0, sizeof(target_fname));
 	return 0;
=20
 }
@@ -141,7 +147,7 @@ int main(int argc, char *argv[])
 		struct hv_do_fcopy copy;
 		__u32 kernel_modver;
 	} buffer =3D { };
-	int in_handshake =3D 1;
+	int in_handshake;
=20
 	static struct option long_options[] =3D {
 		{"help",	no_argument,	   0,  'h' },
@@ -170,6 +176,9 @@ int main(int argc, char *argv[])
 	openlog("HV_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
=20
+reopen_fcopy_fd:
+	hv_copy_cancel();
+	in_handshake =3D 1;
 	fcopy_fd =3D open("/dev/vmbus/hv_fcopy", O_RDWR);
=20
 	if (fcopy_fd < 0) {
@@ -196,7 +205,8 @@ int main(int argc, char *argv[])
 		len =3D pread(fcopy_fd, &buffer, sizeof(buffer), 0);
 		if (len < 0) {
 			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
-			exit(EXIT_FAILURE);
+			close(fcopy_fd);
+			goto reopen_fcopy_fd;
 		}
=20
 		if (in_handshake) {
@@ -233,7 +243,8 @@ int main(int argc, char *argv[])
=20
 		if (pwrite(fcopy_fd, &error, sizeof(int), 0) !=3D sizeof(int)) {
 			syslog(LOG_ERR, "pwrite failed: %s", strerror(errno));
-			exit(EXIT_FAILURE);
+			close(fcopy_fd);
+			goto reopen_fcopy_fd;
 		}
 	}
 }
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index e9ef4ca6a655..3282d48c4487 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -76,7 +76,7 @@ enum {
 	DNS
 };
=20
-static int in_hand_shake =3D 1;
+static int in_hand_shake;
=20
 static char *os_name =3D "";
 static char *os_major =3D "";
@@ -1400,14 +1400,6 @@ int main(int argc, char *argv[])
 	openlog("KVP", 0, LOG_USER);
 	syslog(LOG_INFO, "KVP starting; pid is:%d", getpid());
=20
-	kvp_fd =3D open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
-
-	if (kvp_fd < 0) {
-		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
-			errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
 	/*
 	 * Retrieve OS release information.
 	 */
@@ -1423,6 +1415,16 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
=20
+reopen_kvp_fd:
+	in_hand_shake =3D 1;
+	kvp_fd =3D open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
+
+	if (kvp_fd < 0) {
+		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
+		       errno, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
 	/*
 	 * Register ourselves with the kernel.
 	 */
@@ -1458,7 +1460,7 @@ int main(int argc, char *argv[])
 			       errno, strerror(errno));
=20
 			close(kvp_fd);
-			return EXIT_FAILURE;
+			goto reopen_kvp_fd;
 		}
=20
 		/*
@@ -1623,7 +1625,8 @@ int main(int argc, char *argv[])
 		if (len !=3D sizeof(struct hv_kvp_msg)) {
 			syslog(LOG_ERR, "write failed; error: %d %s", errno,
 			       strerror(errno));
-			exit(EXIT_FAILURE);
+			close(kvp_fd);
+			goto reopen_kvp_fd;
 		}
 	}
=20
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index 92902a88f671..e70fed66a5ae 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -28,6 +28,8 @@
 #include <stdbool.h>
 #include <dirent.h>
=20
+static bool fs_frozen;
+
 /* Don't use syslog() in the function since that can cause write to disk *=
/
 static int vss_do_freeze(char *dir, unsigned int cmd)
 {
@@ -155,8 +157,11 @@ static int vss_operate(int operation)
 			continue;
 		}
 		error |=3D vss_do_freeze(ent->mnt_dir, cmd);
-		if (error && operation =3D=3D VSS_OP_FREEZE)
-			goto err;
+		if (operation =3D=3D VSS_OP_FREEZE) {
+			if (error)
+				goto err;
+			fs_frozen =3D true;
+		}
 	}
=20
 	endmntent(mounts);
@@ -167,6 +172,9 @@ static int vss_operate(int operation)
 			goto err;
 	}
=20
+	if (operation =3D=3D VSS_OP_THAW && !error)
+		fs_frozen =3D false;
+
 	goto out;
 err:
 	save_errno =3D errno;
@@ -175,6 +183,7 @@ static int vss_operate(int operation)
 		endmntent(mounts);
 	}
 	vss_operate(VSS_OP_THAW);
+	fs_frozen =3D false;
 	/* Call syslog after we thaw all filesystems */
 	if (ent)
 		syslog(LOG_ERR, "FREEZE of %s failed; error:%d %s",
@@ -202,7 +211,7 @@ int main(int argc, char *argv[])
 	int	op;
 	struct hv_vss_msg vss_msg[1];
 	int daemonize =3D 1, long_index =3D 0, opt;
-	int in_handshake =3D 1;
+	int in_handshake;
 	__u32 kernel_modver;
=20
 	static struct option long_options[] =3D {
@@ -232,6 +241,10 @@ int main(int argc, char *argv[])
 	openlog("Hyper-V VSS", 0, LOG_USER);
 	syslog(LOG_INFO, "VSS starting; pid is:%d", getpid());
=20
+reopen_vss_fd:
+	if (fs_frozen)
+		vss_operate(VSS_OP_THAW);
+	in_handshake =3D 1;
 	vss_fd =3D open("/dev/vmbus/hv_vss", O_RDWR);
 	if (vss_fd < 0) {
 		syslog(LOG_ERR, "open /dev/vmbus/hv_vss failed; error: %d %s",
@@ -285,7 +298,7 @@ int main(int argc, char *argv[])
 			syslog(LOG_ERR, "read failed; error:%d %s",
 			       errno, strerror(errno));
 			close(vss_fd);
-			return EXIT_FAILURE;
+			goto reopen_vss_fd;
 		}
=20
 		op =3D vss_msg->vss_hdr.operation;
@@ -318,8 +331,8 @@ int main(int argc, char *argv[])
 			syslog(LOG_ERR, "write failed; error: %d %s", errno,
 			       strerror(errno));
=20
-			if (op =3D=3D VSS_OP_FREEZE)
-				vss_operate(VSS_OP_THAW);
+			close(vss_fd);
+			goto reopen_vss_fd;
 		}
 	}
=20
--=20
2.19.1

