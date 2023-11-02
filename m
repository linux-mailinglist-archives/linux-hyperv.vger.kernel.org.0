Return-Path: <linux-hyperv+bounces-658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AB7DFA67
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A09B20CEA
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541F200AB;
	Thu,  2 Nov 2023 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iignz9zw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F50C8D6
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 18:55:54 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF0185
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 11:55:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso17937687b3.0
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Nov 2023 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951350; x=1699556150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1MFejYfcIlhp5L6UBckhhQYL5s7bmRsL3b92h+ON2U=;
        b=Iignz9zw+EjFYVG0WTLlv6bu4Q6K2OBUdMYTf9SNuBsdBgb9ijqpMdbi1sxXtG2xT6
         0aFSNJ0BZ8fHw2Ziq1o2S/1y76vI67IKTEExz69AV9EIstysr+dgkfN/YNd0wIstHd2E
         WvUqxBtKaWJKa6O07F7CGqQDp/9ZWGEglKbYEhApjWGXQFkvSMzR8SuHyQiWpIKpDbx7
         x3kYROKODF4Vc4o5dvylEk525Aatr42k674XcTwm7OmEldDwY8qtPd53vXpGUVCGYHff
         6H6sRKk6bJ/ui8xJ7mRdvgJlIZzAnIixRbbzjChXIOdBnfV6r1Ehg+Og80Tc1cR+ATdO
         O9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951350; x=1699556150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1MFejYfcIlhp5L6UBckhhQYL5s7bmRsL3b92h+ON2U=;
        b=xJlLqj+0uJK3UVdR5iv3B2X4UbIv+2r4r876SMXLNSPVEpRSn+SWOKXj7nPlrKezf7
         iJy4dgd8lsKGwY3/Zp+Cmg4UUArURM2/wwZYeLGPKniW/1gVw69w0wHnvNT1VNkCWCdW
         HhGrXP2SJLt7v1SbIw/C0tOJCgjcVh5hq6s/NMQFnVSFbLwHtDwhOL/ISdqKuoEG14+C
         whPQijo5lddihM5wWRAdb3FylhqJTgA8wETHqcd+QI7FSNF/daKz1hE3ebg/K1zVjaim
         h2ivHua+eqD+tIibM6cG11qBpfRw+UdXzjdXumEWMoSKFEJlFcmDUc+C+zuJS/tKpOKF
         LWdA==
X-Gm-Message-State: AOJu0Yw8EqkiEGN9WcWZCpOs/rJ3wQtK+7ADujrgrcQ2YYutqbqN0Xkk
	OeYHpXI09MeK0JVZVuOj4zUrY3OdxF/qPLTZUg==
X-Google-Smtp-Source: AGHT+IGur+9ubZUYTGwViJK/0T6WuAETQMOPNATCoodiS/vweDFcw/ci9wvenAIu4f9YZlxzEAf34fot3JrUlSjZ+w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:e7d5:0:b0:da1:aff2:bfbc with SMTP
 id e204-20020a25e7d5000000b00da1aff2bfbcmr316486ybh.2.1698951350112; Thu, 02
 Nov 2023 11:55:50 -0700 (PDT)
Date: Thu, 02 Nov 2023 18:55:42 +0000
In-Reply-To: <20231102-ethtool_puts_impl-v4-0-14e1e9278496@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102-ethtool_puts_impl-v4-0-14e1e9278496@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698951347; l=1809;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=CSBVoPDv8bUcjz46YxS9QitvpQ3NGLvmBs8lKX6nt0Y=; b=ahqS7od7MuaYQgDwf1xLYrlZa/EPl4vCGCgO9aqOLDD54X4Mk82mLZTadznG6MV4/eOfOwtgq
 gVYFH7WrWL5BPoocw4PUQQAzqFcybf4biUS6+am4p7pCOnSg+h+I6qg
X-Mailer: b4 0.12.3
Message-ID: <20231102-ethtool_puts_impl-v4-1-14e1e9278496@google.com>
Subject: [PATCH net-next v4 1/3] ethtool: Implement ethtool_puts()
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	"=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	bpf@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Use strscpy() to implement ethtool_puts().

Functionally the same as ethtool_sprintf() when it's used with two
arguments or with just "%s" format specifier.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 include/linux/ethtool.h | 13 +++++++++++++
 net/ethtool/ioctl.c     |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 226a36ed5aa1..7fc0826d443f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1053,6 +1053,19 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
 
+/**
+ * ethtool_puts - Write string to ethtool string data
+ * @data: Pointer to a pointer to the start of string to update
+ * @str: String to write
+ *
+ * Write string to *data. Update *data to point at start of
+ * next string.
+ *
+ * Prefer this function to ethtool_sprintf() when given only
+ * two arguments or if @fmt is just "%s".
+ */
+extern void ethtool_puts(u8 **data, const char *str);
+
 /* Link mode to forced speed capabilities maps */
 struct ethtool_forced_speed_map {
 	u32		speed;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..abdf05edf804 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1991,6 +1991,13 @@ __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...)
 }
 EXPORT_SYMBOL(ethtool_sprintf);
 
+void ethtool_puts(u8 **data, const char *str)
+{
+	strscpy(*data, str, ETH_GSTRING_LEN);
+	*data += ETH_GSTRING_LEN;
+}
+EXPORT_SYMBOL(ethtool_puts);
+
 static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;

-- 
2.42.0.869.gea05f2083d-goog


