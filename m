Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C707551945D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiEDBzJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbiEDByv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 21:54:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A533E04
        for <linux-hyperv@vger.kernel.org>; Tue,  3 May 2022 18:48:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x18so160455plg.6
        for <linux-hyperv@vger.kernel.org>; Tue, 03 May 2022 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgEz4A26uAC0tPMSdTdWzcdcPMkc9MyjUZa57zGhp5c=;
        b=THMBXiotwI/HtB6w2vZ4AUJ2BjQh4hIPsHX7+RZwOa1PHLlgiT/9TXJjWzKZ2YkERx
         +jSME8ruQzJrkosl9qqzWHjBRc3gpjhe8YYA4SgiQV2fs5uQIJ4ItuKhnxn0qRtTRwig
         4dauL4e9jCHwc/wxp5WYhLqZAsMtRYdbGk0Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgEz4A26uAC0tPMSdTdWzcdcPMkc9MyjUZa57zGhp5c=;
        b=4atsnD+m7p1P0U19FyeLJ+UUU6gZ7UMYwiJK/Oh9kHaaV8j8j2IzXGVZ+qJWwBlxim
         fvK3BgSpvKKuJ+TlEqwWDidl/3Q3O1U7F3dvE5IWjxW3dNIHxBu/dRR04c14wq1+wlzw
         aQ8nBkPMJa9OEp59YpM+VOAmDU0VPrjDPWNtAyjmJZF5PpCI9mVVjw9K9p8CwR3V5ih8
         QeS9pM8Kb0W2rJ8CDVySrhFeJn5LC5gXeAfFumsrzfzMDUPq5mvrcsfiAuNEn1XdA8TJ
         8KlOOzfASkb/sbrux0FIN0whA4DwdCZaNHNEaaq5jM17b5sVNfEtNaLb9wypX2ZriiAC
         lyzg==
X-Gm-Message-State: AOAM532Ztxtyo4AwHqSVUKJiYBTuOCYjMK148i7grW/hG61rP9fr5Sv8
        shHr9MqpWx9gSGpLA8cqDy2Tsw==
X-Google-Smtp-Source: ABdhPJxzrexxW/yf0eI3tzcv3meb1lpVecV0BZq4fTM2Rm6r9dsZwj3LUHAp+WFhmr0b7U1/sntV2Q==
X-Received: by 2002:a17:902:da8b:b0:15e:aba7:43fe with SMTP id j11-20020a170902da8b00b0015eaba743femr10560505plx.9.1651628869143;
        Tue, 03 May 2022 18:47:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm6940054pfa.156.2022.05.03.18.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 18:47:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        alsa-devel@alsa-project.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Gross <agross@kernel.org>,
        Andy Lavr <andy.lavr@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        Christian Brauner <brauner@kernel.org>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Chris Zankel <chris@zankel.net>,
        Cong Wang <cong.wang@bytedance.com>,
        Daniel Axtens <dja@axtens.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        devicetree@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Eli Cohen <elic@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <balbi@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hulk Robot <hulkci@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Keeping <john@metanate.com>,
        Juergen Gross <jgross@suse.com>, Kalle Valo <kvalo@kernel.org>,
        Keith Packard <keithp@keithp.com>, keyrings@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux1394-devel@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, llvm@lists.linux.dev,
        Loic Poulain <loic.poulain@linaro.org>,
        Louis Peens <louis.peens@corigine.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Mark Brown <broonie@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Rich Felker <dalias@aerifal.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>, selinux@vger.kernel.org,
        SHA-cyfmac-dev-list@infineon.com,
        Simon Horman <simon.horman@corigine.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Tom Rix <trix@redhat.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        wcn36xx@lists.infradead.org, Wei Liu <wei.liu@kernel.org>,
        xen-devel@lists.xenproject.org,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 26/32] ima: Use mem_to_flex_dup() with struct modsig
Date:   Tue,  3 May 2022 18:44:35 -0700
Message-Id: <20220504014440.3697851-27-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504014440.3697851-1-keescook@chromium.org>
References: <20220504014440.3697851-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; h=from:subject; bh=0OJGwcsHhKZ90NmLpvzscbvuHwuTm4ffAc9aRODTTVY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicdqG62vfnuT12WKQv0IVuyRZyZzMX4U3Y+bYmap0 sx6VNCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnHahgAKCRCJcvTf3G3AJp8HEA CsjdGpDagpIubOZwh4SIwzLI0mQ71SVDOmeVgjaMH3wCaEUbVyUbQcZCwMkSSQkmaYi0JHdt186r90 KEdAes66ANgHJSwIbVxb19utRynHoJDFwO5gfVuTp2sVSu0AKP3KnJZajTXsyucbZynSVAJNanMloi v43qXD0nlRXkU0gX5ADpraYNTEc4DmC1I4QdBks60+U4wHFdhcjQvwo5U7V+5dzuva3RK7ldVtXJrB VeE5PpJQ5Xc1tmru3dEvFHv9MKipcoi+cf2u17BgJcgfDnUcb/oIr/jZVk1w2GF8Ilp5rtUyr0DM8m Na/yIL9jeaPARJok7fgLZP9afaRB6ZwWwE4H2uMjCy1cT6gasjHiZsGre3gXlWVcsFQqLjohy6kCxW rBj7pLN4d++yrxKprYmKAt3zeatf5EMTvrLIgqFUOrk/sAwpHwlXmgGTkAeWNhT8J5VVKpaeshrS8f gKI9RgmhD5seOLoAZLEOSns1PPAdryQb5THkD3O+72gLN08L6etoAPODJ68wd7fcwq7Wg5n5/+AkF2 1jkeaI8b1sgNrwkPOtdnKDQm4yxesI//AmfFdH7EEjbVd52gAVu+rbz7yhcBh1dHRczes2IJW3soaR v4zCatjhXz33SY1+Zru2qRrDvhgaoAqzqRxMbwi9eNYoszXDTRyDKQ8NgEFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As part of the work to perform bounds checking on all memcpy() uses,
replace the open-coded a deserialization of bytes out of memory into a
trailing flexible array by using a flex_array.h helper to perform the
allocation, bounds checking, and copying.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/ima/ima_modsig.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..200c080d36de 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -28,8 +28,8 @@ struct modsig {
 	 * This is what will go to the measurement list if the template requires
 	 * storing the signature.
 	 */
-	int raw_pkcs7_len;
-	u8 raw_pkcs7[];
+	DECLARE_FLEX_ARRAY_ELEMENTS_COUNT(int, raw_pkcs7_len);
+	DECLARE_FLEX_ARRAY_ELEMENTS(u8, raw_pkcs7);
 };
 
 /*
@@ -42,7 +42,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 {
 	const size_t marker_len = strlen(MODULE_SIG_STRING);
 	const struct module_signature *sig;
-	struct modsig *hdr;
+	struct modsig *hdr = NULL;
 	size_t sig_len;
 	const void *p;
 	int rc;
@@ -65,8 +65,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	buf_len -= sig_len + sizeof(*sig);
 
 	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
-	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
-	if (!hdr)
+	if (mem_to_flex_dup(&hdr, buf + buf_len, sig_len, GFP_KERNEL))
 		return -ENOMEM;
 
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
@@ -76,9 +75,6 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		return rc;
 	}
 
-	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-	hdr->raw_pkcs7_len = sig_len;
-
 	/* We don't know the hash algorithm yet. */
 	hdr->hash_algo = HASH_ALGO__LAST;
 
-- 
2.32.0

