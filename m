Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1E4C5CAA
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Feb 2022 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiB0Pxl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Feb 2022 10:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiB0Pxl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Feb 2022 10:53:41 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2123.outbound.protection.outlook.com [40.107.95.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238E28E1F;
        Sun, 27 Feb 2022 07:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUvrZ1nf0JJxBcu1tV7NVbQVQnN2g0006IB+Y/xuFShH/ZMdZSteOsfKVc2tl3TlN4yQjt+N6Vp/8w7JMpvJPhcZhQwATG3a/5IdBkMH8XFd0UiUrOfkWrj2Tyjw4sPFWgcfOWTM0W1lhfqI9ufLASjdRiUagc36gdO7iyuYXOjhxhtpjTx0tnpvVuUPTZynID+RdkuYZVx0hsnl550Ykomg8G29WEKngy2CwdDy5PzbXO40kGScJHWmVvyv66TY7opd4/6QAw8L2V81D0vY3iWnkeU9qjOyiCDu1LZPGWljX/Jj986g2ZLsue5Ls7EFojkicbeBW+LrRUuTwEeLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5MpYU+R3yeg/GySAs2eiprasrvco6MaaLUf40Me7V0=;
 b=RQEed/W3meB4gWNzSCaGas9uxrh6F65gR4Gst+BeRSukeG0eelYRYWROGskM4Ruij4X9wzvtm+PjlR49Xczg8LAxwmdKC8NqgCsznTNd6jBJuW/OUqFA5N+Km9/6cUD1YxmUDwOt48EFDus4+r3mJ2FP8UOBtZ/xu08+rMjxZ9qV9Z6fKNsm9J+FKVRW4euFA6P39BKoLWZ2Jp8+eC2BrCDoMPg4aAygYYSeLRTb1V1eIjekPMuTg59ITt68IZr4ylL06P2ts5E//KOX0k06XrZXozc0Dm7nKwWcPKTla7vxeEHUFz8g8nRO3INrMG6u86fVMIIi+krreawGSMyI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5MpYU+R3yeg/GySAs2eiprasrvco6MaaLUf40Me7V0=;
 b=Lu6BxTpYzyxeHyrDwyq9Jn4kyA7eBBksljkrGSRJtHFIbwqqDwnR3eMq42Q/J3NV+zwiKUDDnU7YGdViHPpJVuvRXHYlauPazeesrGWel8RWqDFyxGY0LMtvKcx71BaCDEWRmy1uiSfSq/I5kqRU0ItKmudYrE9DiV5gs42W6VY=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by MN0PR21MB3384.namprd21.prod.outlook.com (2603:10b6:208:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Sun, 27 Feb
 2022 15:53:01 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Sun, 27 Feb 2022
 15:53:01 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH v3 04/11] hv: Use driver_set_override() instead of
 open-coding
Thread-Topic: [PATCH v3 04/11] hv: Use driver_set_override() instead of
 open-coding
Thread-Index: AQHYK+FckIRUQCAZmEqm74E1fgzZE6ynizFQ
Date:   Sun, 27 Feb 2022 15:53:00 +0000
Message-ID: <MN0PR21MB30980EDB65A4CE643990635FD7009@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-5-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227135214.145599-5-krzysztof.kozlowski@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a42ede4f-4007-465b-a95d-466cf4e30263;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-27T15:48:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3d1ed8c-400e-4f68-96a6-08d9fa093b9d
x-ms-traffictypediagnostic: MN0PR21MB3384:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN0PR21MB338498506434E964B2C21C4FD7009@MN0PR21MB3384.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DsZvhnJsgBy4hcyBdF24BcIqlIet8SDRZjzhA4we36uhLdNOL/qPAf0soespQmTKHh7k28ISobqQEPJO8Vsx0w9eNmLhNVoAlhOvkKZB2Ds1Mn/+B33wrSfIwyiTzwMK0jsEhAqj4nwFJGVKW6pgr7wj9VNFv27Sz2l5Z3LLP4gRDkO1mMWjAVgEui2hS/3fGd+nqxB3aJTdhLsbxmwOIJw1FwI/jQtZgzuxsWZAbvkszPE61uJCixjn4Y15waGdURkmSSzfoI7L9YH97335wlLdIXnd+1GgtkVjm4JUR6g8VIJNpTAuXsa9AiUstmgCugZyA/9t0Y02eVp7la/pop6re90EASQYDi3dj58rkPI5fodVfzLqidLyxrG2DoQGQvbPFUPqVRqFR7c6/5etf5r0GKSqwRd0I1WORd3sBn2twvOXUff+D+VHKntDJv732JTW0V6gsbcQMjXa8ESlNCSkkehC7fRH+aoDuoh5nvp+58oP1M4/wOESRSxTtUj3TzMU2GLJ8paoDvJMLtoUTIiX8teqYbHniWxjXqlsTXT/Zc1YrO7B3RQyH67WgAu4cDJWcBZM/z/k8ewLp3jb9lSDei7ulHoaXm/yn3qQ0TlU4oBARbzcICSjHZRIXsuaHzAUBLyfFYz3eLkmaTV85o5d1Ps3so8vVfabZOF36RI+mhq54s7RI+lLRAk5E7mTS37pgwae8yvIR5GowFJiUxTEJ3tbY7EEb/dVsCc6FxS/8TIEP4/fdRXQOfA/4v5GzlU3rhNN2P67FrSysTViw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(82950400001)(110136005)(921005)(9686003)(2906002)(316002)(38070700005)(86362001)(122000001)(186003)(508600001)(10290500003)(7416002)(7406005)(5660300002)(8990500004)(26005)(7696005)(6506007)(4326008)(71200400001)(55016003)(33656002)(82960400001)(83380400001)(8936002)(64756008)(8676002)(66946007)(66446008)(52536014)(66556008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMgwLaTJkeBdNQmItVe396aKj14chfUmxXPbIae7fO/x3HRuDBvgIqjsF1vD?=
 =?us-ascii?Q?PuUijf78zDjvl5wwHTNXWeYGOj12ok1O1o5XM+Si+PkDyl4WX4QaJzWQ+UMp?=
 =?us-ascii?Q?whdFZzUTcDbHNqk3gUSfJbITSBt4G/PEm5MiQPRk5DfhcpknivaXCFIrmZBn?=
 =?us-ascii?Q?1sSDPyGSuilnxISfU3z71DtWujsjyNXJN6pbdfSr3UoE8CdolQQ6G0jRFtsb?=
 =?us-ascii?Q?qHZnaliTLNiN5jT057Kbxs5PUS7BCIs7XMPir0PpHDaMOhBoXm2WhNc/yabe?=
 =?us-ascii?Q?nEq/GqsHia936CF/IUUmLN766yFLyucpfqN67d/ACrvIEQBAv32KoG9Tq7mZ?=
 =?us-ascii?Q?Iql2TLw8vv1DndMhSp/kaXNmooYl3v2Xlop3YoBX0dm79vaENwaFXAR7jxtO?=
 =?us-ascii?Q?BYpfSmuMq/11Wos9xuwxlZrgsmBXh8TP1+1W+9KjrRA90gkfB/wjL2j+Qe8M?=
 =?us-ascii?Q?QXai++NRFkoML7mZP+/tdoaVysf1FGaQ4kH2B8klFZzfnyY4eh3NxIcdopCT?=
 =?us-ascii?Q?2bkUCTLWjFet3+wKBBKYropHw4HTPuOpL4tpN917X6iz7PIbcN2vj/BpkTgu?=
 =?us-ascii?Q?6D4uIe1KdvWptCZM9+Pc38M/nvilOKvsmtHvPKAd6S2r5L+BE3/BTzUNsPmU?=
 =?us-ascii?Q?aEpowQh+EiZOfd9jSrA6Osd63ql5d0AEWEGL52rqNyjVZP8Z0qZ5aarLFIGc?=
 =?us-ascii?Q?39+vaAgqTUP4Vb28frF0LDGTQSQzYia0Gi/v2NX55aRAXsB3xVl1nOQ97TjP?=
 =?us-ascii?Q?DkI8197peAWtjDyU6rT2x5WwBOzuOljM1taSz+qgiRvO53Htf1wQIsxaEYQJ?=
 =?us-ascii?Q?iiMQH/aFNTBzaYV7J4SyZHcTdDBKD9aRLTk+cIu3Adam3joPP7iEEJxZd7Bj?=
 =?us-ascii?Q?ryBNpmPD5ToCdHQkJevjIJBB2Jj0GOVfYxL+SmiuVKs0hJ7jpn9nSGkj5nOp?=
 =?us-ascii?Q?LUWhGIpVmu0C1tcX0LgfqtasbrWsTmdk9MNQIuLrVhwnVbIWWmmNai07QDuK?=
 =?us-ascii?Q?DOwLAbYYcgeHFHScoXv/uR6iPyHSQQ+pRbjnGV5jTrYcXFYH/8lJ+ZL0Ellk?=
 =?us-ascii?Q?gbS6t7hJEtKKabZjV0fT4Prq5OJ5wSFbkEwY64Yh9bbznxTYqz/saUrz8kCk?=
 =?us-ascii?Q?OIN8EWLH7gcdRt6XWBxv51viHM1r+IIkF9Ie1KgNxYNPA+fXJ/Ih9muUYzS+?=
 =?us-ascii?Q?IcVrsAfPT1+RwjHoj4ZkLgAN7A7XO8Z8xKZ4Q+O7v+N4ar18LqwZctLvEqXr?=
 =?us-ascii?Q?x3vujWrpt/XDZ6LDWsGKt/jXbVXNVadgT1kELeQbAo6IpQNYvJGL/N4CeDiL?=
 =?us-ascii?Q?DCllBpoGPatWZE6ivNCTKgil9FoYA+ZdPE+fW0Stun3lcraDQxdOJkhifo7f?=
 =?us-ascii?Q?bdHi32JgMlZp4p+EPai2lw7cecM/3eU9Y15tKS8oxDh8SGVuwPrhS6/bRsLX?=
 =?us-ascii?Q?gVdLPBnqZlZnEERqLAn9azgC7Mq+C8thiNOZEmYXuEK813vtfFLF2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1ed8c-400e-4f68-96a6-08d9fa093b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2022 15:53:00.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDOXGdO1qmEgbik6eJDNhDD+uhSLmDsN42bfXfMe1dm2pt8yFJLKPqofVIHfDtR3qE+lQBwgCqkIanlTzNaMyvnaiNytkv7Uf5yywIOAowk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3384
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> Sent: Sunday,=
 February 27, 2022 5:52 AM
>=20
> Use a helper for seting driver_override to reduce amount of duplicated
> code. Make the driver_override field const char, because it is not
> modified by the core and it matches other subsystems.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/hv/vmbus_drv.c | 28 ++++------------------------
>  include/linux/hyperv.h |  7 ++++++-
>  2 files changed, 10 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37e87f3..a0ff4139c3d2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -575,31 +575,11 @@ static ssize_t driver_override_store(struct device =
*dev,
>  				     const char *buf, size_t count)
>  {
>  	struct hv_device *hv_dev =3D device_to_hv_device(dev);
> -	char *driver_override, *old, *cp;
> -
> -	/* We need to keep extra room for a newline */
> -	if (count >=3D (PAGE_SIZE - 1))
> -		return -EINVAL;
> -
> -	driver_override =3D kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp =3D strchr(driver_override, '\n');
> -	if (cp)
> -		*cp =3D '\0';
> -
> -	device_lock(dev);
> -	old =3D hv_dev->driver_override;
> -	if (strlen(driver_override)) {
> -		hv_dev->driver_override =3D driver_override;
> -	} else {
> -		kfree(driver_override);
> -		hv_dev->driver_override =3D NULL;
> -	}
> -	device_unlock(dev);
> +	int ret;
>=20
> -	kfree(old);
> +	ret =3D driver_set_override(dev, &hv_dev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
>=20
>  	return count;
>  }
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index fe2e0179ed51..beea11874be2 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1257,7 +1257,12 @@ struct hv_device {
>  	u16 device_id;
>=20
>  	struct device device;
> -	char *driver_override; /* Driver name to force a match */
> +	/*
> +	 * Driver name to force a match.
> +	 * Do not set directly, because core frees it.
> +	 * Use driver_set_override() to set or clear it.
> +	 */
> +	const char *driver_override;
>=20
>  	struct vmbus_channel *channel;
>  	struct kset	     *channels_kset;
> --
> 2.32.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

