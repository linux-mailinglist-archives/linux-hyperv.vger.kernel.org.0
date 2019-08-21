Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E99878A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 00:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfHUWwI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 18:52:08 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:17472
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729892AbfHUWwI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 18:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Loe51eiKF06R734w/njHJIBcJKc6896rQTwZ3/w0BhU2ATTjdHYytmCurasHsTE4u5Jd8vZy3wM2uGlOYI+qwfUmTHC5jp2agQKn1zTD4uL1VW1ecfik2XUTYj7YGrellcRDDWDoSQHdTKVfevPj/yHaQbm6hiX+Muhq36MUGBaAewfHuHyc4+dHDwVLsfD7zxnuBpx1ZS7TFcW/4nOlkUb2mG/wAk4/SIurosigt27YdmsOLc6eAOAF0h24tPaw/wQ9nWciKHKqb5ATXLGzhT9qhoib1HE0/kqA2F4y4t2Ra9Yv3mj/rSwzrUQuBdIWVaUexhIgQpTN7nqyEyrQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3WJkNfsBwTw5LUMVVgIzAZfCHlZQ4uwjjh7IUadVm4=;
 b=Q9mun3WOSKetK2wY1wJRQLPm9KP2+RaRxNvVPWyGv1dTNcbvqREo+6xNGxy0GxPTWui0ylr6k5IX2nNATHwIW0MqZNj1MjSoxb2MrxSkL7axkts5yQUs9hdrHYHP9qYtoh8XQPjkmrdgH75Co4eeUyAqe6oYtPV3LZz0E5vkEveuJtrUuv3+VHjzY2WK7JZuGyGQbH+83srXhK18RK36rSHbdRoqYNPR+r0SOGjZAAjt5GzmObBq7TEU94KVQah/iTSAePE95UzxK8zf0p1kqah50/mFPU4Qxz919ATXIe4naFXXuwMPcdHNrEv2uDuaGo15qk9r/MSFoLxsyFtwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3WJkNfsBwTw5LUMVVgIzAZfCHlZQ4uwjjh7IUadVm4=;
 b=ibnhutbWp4e1WyUfAdc7rVZdJv/G1neHAp+HBwns20YuCykG5vCaauGC5WRT0WDXSBoKQoht25IQrpmtrgFvSQo54hhNmE/iWCDtVP1Yio57gRL2fq39xsEMO8cLi4++mI9FLwHDK/N/UX9f2J40U/jPHLDNq27OALQI5Ed5zfQ=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0153.namprd21.prod.outlook.com (10.173.173.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Wed, 21 Aug 2019 22:52:04 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 22:52:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Thread-Topic: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Thread-Index: AQHVVwE2vVCk3RDz8U68oyYvQlF7g6cGJmDQ
Date:   Wed, 21 Aug 2019 22:52:04 +0000
Message-ID: <DM5PR21MB01375C24AE9ECD93DBE856C2D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
 <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
In-Reply-To: <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-21T22:52:02.8650892Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=165c4a81-c33f-47b4-8d0e-653907e32f15;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceaa9a21-3355-489e-5b03-08d7268a300a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0153;
x-ms-traffictypediagnostic: DM5PR21MB0153:|DM5PR21MB0153:|DM5PR21MB0153:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0153DB46822EAAC6146BF7AFD7AA0@DM5PR21MB0153.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(55016002)(26005)(186003)(6436002)(66066001)(71200400001)(5660300002)(52536014)(54906003)(446003)(10290500003)(71190400001)(66946007)(1511001)(25786009)(76116006)(486006)(4326008)(476003)(86362001)(229853002)(7696005)(6246003)(2906002)(66556008)(11346002)(256004)(99286004)(66476007)(66446008)(53936002)(76176011)(64756008)(81156014)(8676002)(14454004)(316002)(33656002)(102836004)(22452003)(8990500004)(9686003)(8936002)(3846002)(478600001)(6116002)(305945005)(2501003)(6506007)(110136005)(7736002)(10090500001)(74316002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0153;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T8KmCQVYTIqRK6E+mGt64TMFqXbwTjFf6+zNCmwZqbIen18ck2wLKzh9AIcKQ2ccELqwvk3fz75qYv0AIzXQSI9rI5Dh9S2iTz4HA82g3wn2ep9yaJm766hm3ic4LdByvoXM83PIHXKnBe6VrflA4vBHfxrO0Ny4Mw1pbPelb/TFFGzs+itUNH5rAywKyfWNeOqpdxq/amFXB5xbyskRN5olGGCokj7fhf7aF9A5XII+Gyk1+aETEhKLgQkiJcT7odh/skRJpNeEDQh6z9DBkVpaiQZXgsNdtv+XOfifi88l9ZdQRbiu9soNO4JmY1YI72N1E1tZ4O4Ce1UfmpzATvzG6LAaJ15kEtjrk9kML13YL1k41SMnAAZzY5LLGVTQGp+Bl7IK4rQiPebV03BrHD2IXAgrHeogdRAySGXt60s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa9a21-3355-489e-5b03-08d7268a300a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 22:52:04.7842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypAH3KCoPIHid/agWnlT49HCHmfOPdf90l9aSRUqsFbcMLg8Xm5vWrUk+oQU8EbnXBCeMD/Qm9yZClvL9+zv30uLwaQn4dxoyr5KDMwfXvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Monday, August 19, 2=
019 7:45 PM
>=20
> Introduce user specified latency in the packet reception path.
>=20
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
> Changes in v2:
>  - Add #ifdef in Kconfig file so test code will not interfere
>    with non-test code.
>  - Move test code functions for delay to hyperv_vmbus header
>    file.
>  - Wrap test code under #ifdef statement.
>=20
>  drivers/hv/Kconfig        |  7 +++++++
>  drivers/hv/connection.c   |  3 +++
>  drivers/hv/hyperv_vmbus.h | 20 ++++++++++++++++++++
>  drivers/hv/ring_buffer.c  |  7 +++++++
>  include/linux/hyperv.h    | 21 +++++++++++++++++++++
>  5 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 9a59957922d4..d97437ba0626 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -29,4 +29,11 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config HYPERV_TESTING
> +        bool "Hyper-V testing"
> +        default n
> +        depends on HYPERV && DEBUG_FS
> +        help
> +          Select this option to enable Hyper-V vmbus testing.
> +
>  endmenu
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 09829e15d4a0..c9c63a4033cd 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -357,6 +357,9 @@ void vmbus_on_event(unsigned long data)
>=20
>  	trace_vmbus_on_event(channel);
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> +#endif /* CONFIG_HYPERV_TESTING */

You are following Vitaly's suggestion to use #ifdef's so no code is
generated when HYPERV_TESTING is not enabled.  However, this
direct approach to using #ifdef's really clutters the code and makes
it harder to read and follow.  The better approach is to use the
#ifdef in the include file where the functions are defined.  If
HYPERV_TESTING is not enabled, provide a #else that defines
the function with an empty implementation for which the compiler
will generate no code.   An as example, see the function definition
for hyperv_init() in arch/x86/include/asm/mshyperv.h.  There are
several functions treated similarly in that include file.


>  	do {
>  		void (*callback_fn)(void *);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 362e70e9d145..edf14f596d8c 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -357,4 +357,24 @@ enum hvutil_device_state {
>  	HVUTIL_DEVICE_DYING,     /* driver unload is in progress */
>  };
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>

Generally #include files should go at the top of the file, even if they
are only needed conditionally.

> +#define TESTING "hyperv"

I'm not seeing what this line is for, or how it is used.

> +
> +enum delay {
> +	INTERRUPT_DELAY	=3D 0,
> +	MESSAGE_DELAY   =3D 1,
> +};
> +
> +int hv_debug_delay_files(struct hv_device *dev, struct dentry *root);
> +int hv_debug_add_dev_dir(struct hv_device *dev);
> +void hv_debug_rm_dev_dir(struct hv_device *dev);
> +void hv_debug_rm_all_dir(void);
> +void hv_debug_set_dir_dentry(struct hv_device *dev, struct dentry *root)=
;
> +void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay=
_type);
> +

This is where you could put a #else and the null implementation of
the above functions.

> +#endif /* CONFIG_HYPERV_TESTING */
> +
>  #endif /* _HYPERV_VMBUS_H */
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 9a03b163cbbd..51adda23b398 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -396,6 +396,10 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct
> vmbus_channel *channel)
>  	struct hv_ring_buffer_info *rbi =3D &channel->inbound;
>  	struct vmpacket_descriptor *desc;
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +	hv_debug_delay_test(channel, MESSAGE_DELAY);
> +#endif /* CONFIG_HYPERV_TESTING */
> +
>  	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
>  		return NULL;
>=20
> @@ -421,6 +425,9 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
>  	u32 packetlen =3D desc->len8 << 3;
>  	u32 dsize =3D rbi->ring_datasize;
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +	hv_debug_delay_test(channel, MESSAGE_DELAY);
> +#endif /* CONFIG_HYPERV_TESTING */
>  	/* bump offset to next potential packet */
>  	rbi->priv_read_index +=3D packetlen + VMBUS_PKT_TRAILER;
>  	if (rbi->priv_read_index >=3D dsize)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 6256cc34c4a6..6bf8ef5c780c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -926,6 +926,21 @@ struct vmbus_channel {
>  	 * full outbound ring buffer.
>  	 */
>  	u64 out_full_first;
> +
> +#ifdef CONFIG_HYPERV_TESTING
> +	/* enabling/disabling fuzz testing on the channel (default is false)*/
> +	bool fuzz_testing_state;
> +
> +	/* Interrupt delay will delay the guest from emptying the ring buffer
> +	 * for a specific amount of time. The delay is in microseconds and will
> +	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
> +	 * The  Message delay will delay guest reading on a per message basis
> +	 * in microseconds between 1 to 1000 with the default being 0
> +	 * (no delay).
> +	 */
> +	u32 fuzz_testing_interrupt_delay;
> +	u32 fuzz_testing_message_delay;
> +#endif /* CONFIG_HYPERV_TESTING */

For fields in a data structure like this, you don't have much choice
but to put the #ifdef directly inline.  However, for small fields like this
and where the data structure isn't size sensitive, you could consider
omitting the #ifdef and just always including the fields even when
HYPERV_TESTING is not enabled.  I don't have a strong preference
either way.

>  };
>=20
>  static inline bool is_hvsock_channel(const struct vmbus_channel *c)
> @@ -1166,6 +1181,12 @@ struct hv_device {
>=20
>  	struct vmbus_channel *channel;
>  	struct kset	     *channels_kset;
> +
> +#ifdef CONFIG_HYPERV_TESTING
> +	/* place holder to keep track of the dir for hv device in debugfs */
> +	struct dentry *debug_dir;
> +#endif /* CONFIG_HYPERV_TESTING */

Same here.

Michael

> +
>  };
>=20
>=20
> --
> 2.17.1

