Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2413C1498C4
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 05:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAZEtU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 23:49:20 -0500
Received: from mail-mw2nam12on2137.outbound.protection.outlook.com ([40.107.244.137]:52193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729014AbgAZEtU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 23:49:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXIfPBZlSgz5lNnE4Xz8ANcuEml0TW4Y9oP5fcjbK8sUhcc5q2DiySz05sIKjYBw/As4jgNH9fOWv7UOpeAX2zwiVnbqgclIHsdneMEOZaSMJYOVIQrpuxTrSqYEjFU+MCdlbdM1dsQwjt84mgBXxMBSImg5QQhCVDiNrvq6GZqkXrgNvgi+FEhdI6Z3oKolVBlhKVoGPVl8r98mrGrLojq/kiiGo638mfnkBgpDmig5Q84gvLB3g7M+OZ9qBjeNwBQLM7rd0QpNZ3C+UQNi5bFtKtLKgDIqGGIQr1ko0jta61sekM+lJ0FTdiclKbcGXJSyQF4LPvqMSwdGfDCm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qTfxQxYzB08kr8opDAgK8KkIWioFEOjNsWy1uHeqMI=;
 b=NL6/o95I5NTirDxW/i5eVbb0ycyW/EgNhiqZAdotUZhQxVUKxzfFh+ndMhBmyvYrPdavO8LfSkd7BWdi9Wng1nAsZwlYJKrvsazx7jgenTVqY0V0Z/g8z4wLTI7UMoGw1PcRn2PDmv1KSCZA8lPIh8mJnHcb3kCiozKheLlfmRzWqk7QrjNPeDnOctjK8k3gfR2qAo8pVGaBQnYf0Hsjv+fg/+Bh8DsQtk0AknPap64PIyuH+M7BB/AEq8oCZXxNgfhW9nh1SJTtAaFugy6KElNri/qhPmnMgy0dRjR+J/tNDNWddYHTZuKJlTpeg2a7zf7jSI1fIga2cLHKzvfHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qTfxQxYzB08kr8opDAgK8KkIWioFEOjNsWy1uHeqMI=;
 b=WVJ9pYu/53LDGKNWqhDETCtWKOF3QKdMvXjxCWEC3P3LgdjN546AMXLMklmZFh4EBqpMKM3sqizx0oYOIt+rtajn+DnNl25pXrQc2fLH84vLKqDtrhFskOol2uX4Lpz4DdvW+OUm/hy6EGalF6C2Eq8Dkv1fvh1DiHJf6nT6rIQ=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Sun, 26 Jan 2020 04:49:15 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 04:49:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AQHV07lVd95yjtgTiE+JQQ3vMAq0wKf8XnwA
Date:   Sun, 26 Jan 2020 04:49:15 +0000
Message-ID: <MW2PR2101MB105256D6229F97FC16DC4735D7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
 <1579982036-121722-2-git-send-email-decui@microsoft.com>
In-Reply-To: <1579982036-121722-2-git-send-email-decui@microsoft.com>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a55a73bd-8dd6-48dc-5e38-08d7a21b18a0
x-ms-traffictypediagnostic: MW2PR2101MB1116:|MW2PR2101MB1116:|MW2PR2101MB1116:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1116304D71E1B2573377C415D7080@MW2PR2101MB1116.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(81156014)(316002)(81166006)(7696005)(9686003)(71200400001)(55016002)(2906002)(33656002)(8936002)(10290500003)(110136005)(478600001)(5660300002)(6506007)(86362001)(66446008)(8990500004)(76116006)(26005)(66946007)(64756008)(66556008)(66476007)(186003)(52536014)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1116;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBzAe8q8neaFcqQOn8TL4q1POnf1HaZuv60ei3iW8yxBSiZPcQb4u8ceCgQz0emgbGlEHc0EeUfsM4jGIz1brYkxZQ3NQsZMjpA2iUc2eL8tE8ZVNqtsXH9IfKnLEeIhXP4Goa2bUdeQ6W+to8LzDYF1hItVu2nzyKcq0Yl8lMPQOqCHPRFlNcX9es9zZZqXlGoxBhLpmeZ3181PNXEgp89wEQu0WhX2tINbttVKPiYPLWKL8A+dS0CYC5ESaqZtOQIDJ3VW1V9x69rFYJRE5Fig1E4D72Mqxtu5vYNatHXyhWv1ksQO68K+uneM6SRe6DlfamK3cMBZnbJ24URoz4ZjIIUaFy093/FKU62dXPI5njFZntdC6nNXIl0/1M/mOpxr58N/b+D6xy4KRLS+9q8dTfUwdr+J+ra22m694GFY6xCL6kq3k6Ttxgcuh7b+
x-ms-exchange-antispam-messagedata: XcdUREvGLKMssgI1lfsuNpK3cbaBEjiGpxorEkYSG+xzKeZNp35Urn75TthTiIys74Lp7LDDvOIKjc6KzbpLQJ0Why9cu8pTlikrwIIgTEZY/TEkRhgxru5oOVoLEKQiY3tHupPI7p1+0Uuopn8hpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55a73bd-8dd6-48dc-5e38-08d7a21b18a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:49:15.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eV8vgzy/Ur/jFdieGkSLPjBMa2Zp57bON/hTvGJk/IJkuKxKCYw4e0W0pyzNM8rIKRcEfVeuObyqb9o1NZYPWFSnRQ7qduCpho7rg8rIP0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1116
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 11:=
54 AM
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
>=20
> ---
> Changes in v2:
>     This is actually a new patch that makes the daemons more robust.
>=20
> Changes in v3 (I addressed Michael's comments):
>     Don't reset target_fd, since that's unnecessary.
>     Reset target_fname by: target_fname[0] =3D '\0';
>     Added the missing "fs_frozen =3D true;" in vss_operate().
>     After reopen_vss_fd: if vss_operate(VSS_OP_THAW) can not clear
>         fs_frozen due to an error, we just exit().
>     Added comments.
>=20
>  tools/hv/hv_fcopy_daemon.c | 33 +++++++++++++++++++++----
>  tools/hv/hv_kvp_daemon.c   | 36 ++++++++++++++++------------
>  tools/hv/hv_vss_daemon.c   | 49 +++++++++++++++++++++++++++++---------
>  3 files changed, 88 insertions(+), 30 deletions(-)
>=20
> diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
> index aea2d91ab364..48cfa032432c 100644
> --- a/tools/hv/hv_fcopy_daemon.c
> +++ b/tools/hv/hv_fcopy_daemon.c
> @@ -80,6 +80,8 @@ static int hv_start_fcopy(struct hv_start_fcopy *smsg)
>=20
>  	error =3D 0;
>  done:
> +	if (error)
> +		target_fname[0] =3D '\0';
>  	return error;
>  }
>=20
> @@ -108,15 +110,29 @@ static int hv_copy_data(struct hv_do_fcopy *cpmsg)
>  	return ret;
>  }
>=20
> +/*
> + * Reset target_fname to "" in the two below functions for hibernation: =
if
> + * the fcopy operation is aborted by hibernation, the daemon should remo=
ve the
> + * partially-copied file; to achieve this, the hv_utils driver always fa=
kes a
> + * CANCEL_FCOPY message upon suspend, and later when the VM resumes back=
,
> + * the daemon calls hv_copy_cancel() to remove the file; if a file is co=
pied
> + * successfully before suspend, hv_copy_finished() must reset target_fna=
me to
> + * avoid that the file can be incorrectly removed upon resume, since the=
 faked
> + * CANCEL_FCOPY message is spurious in this case.
> + */
>  static int hv_copy_finished(void)
>  {
>  	close(target_fd);
> +	target_fname[0] =3D '\0';
>  	return 0;
>  }
>  static int hv_copy_cancel(void)
>  {
>  	close(target_fd);
> -	unlink(target_fname);
> +	if (strlen(target_fname) > 0) {
> +		unlink(target_fname);
> +		target_fname[0] =3D '\0';
> +	}
>  	return 0;
>=20
>  }
> @@ -141,7 +157,7 @@ int main(int argc, char *argv[])
>  		struct hv_do_fcopy copy;
>  		__u32 kernel_modver;
>  	} buffer =3D { };
> -	int in_handshake =3D 1;
> +	int in_handshake;
>=20
>  	static struct option long_options[] =3D {
>  		{"help",	no_argument,	   0,  'h' },
> @@ -170,6 +186,10 @@ int main(int argc, char *argv[])
>  	openlog("HV_FCOPY", 0, LOG_USER);
>  	syslog(LOG_INFO, "starting; pid is:%d", getpid());
>=20
> +reopen_fcopy_fd:
> +	/* Remove any possible partially-copied file on error */
> +	hv_copy_cancel();

Since you have removed the calls to close(fcopy_fd) after a
pread() or pwrite() failure that were in v2 of the patch, I was
expecting to see

	if (fcopy_fd !=3D -1)
		close(fcopy_fd)

here, like you've done with the kvp and vss code.  And
remember to initialize fcopy_fd to -1. :-)

Michael

> +	in_handshake =3D 1;
>  	fcopy_fd =3D open("/dev/vmbus/hv_fcopy", O_RDWR);
>=20
>  	if (fcopy_fd < 0) {
> @@ -196,7 +216,7 @@ int main(int argc, char *argv[])
>  		len =3D pread(fcopy_fd, &buffer, sizeof(buffer), 0);
>  		if (len < 0) {
>  			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
> -			exit(EXIT_FAILURE);
> +			goto reopen_fcopy_fd;
>  		}
>=20
>  		if (in_handshake) {
> @@ -231,9 +251,14 @@ int main(int argc, char *argv[])
>=20
>  		}
>=20
> +		/*
> +		 * pwrite() may return an error due to the faked CANCEL_FCOPY
> +		 * message upon hibernation. Ignore the error by resetting the
> +		 * dev file, i.e. closing and re-opening it.
> +		 */
>  		if (pwrite(fcopy_fd, &error, sizeof(int), 0) !=3D sizeof(int)) {
>  			syslog(LOG_ERR, "pwrite failed: %s", strerror(errno));
> -			exit(EXIT_FAILURE);
> +			goto reopen_fcopy_fd;
>  		}
>  	}
>  }
