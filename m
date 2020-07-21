Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6A2277B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jul 2020 06:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGUEqH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jul 2020 00:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUEqH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jul 2020 00:46:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1AC061794
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so11373772pgb.6
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZihfE8PdTkcmFog/NE9+3wOqDTSKN/yPTD5RUiTCo78=;
        b=T2UjdX/aBACNNI7AsLQjD7SodT7yMVIiZtg+gM7ReuX0a9g3/anzmj5Sy0T7rk7aTL
         TWJYwrxOPJ7WxwdJJ4Ez+FxDL++sED71D1PI+CaLd4FnofQovWaciZtcwQ07Ak9b+lCr
         e6jjHDCkxPu/Awzud68wB04RT50d/YR9p6cUTD0uV3IVxvF0dVp0L+JDS4hbcs8gVtLK
         uULi+DH4czQJlXGMesPcjetG+xIZZ2vl7/pK6qMquqOkqMNL+mu2W6QjGe70JjD0I97W
         qu+ZEyZ1I3D3Zhqhi3Py/gK3lk6vTVeWNA7OR44LLWz5O3oYVe50gTHzT3mEDLvCELCl
         9oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZihfE8PdTkcmFog/NE9+3wOqDTSKN/yPTD5RUiTCo78=;
        b=WiLLHFoQ2xYRmC0hmJNZXhfcXrTDIbCoZigwGuZAc7DjzWb2qfo1thD6wBQYGDFH42
         TUE3k1uTe2nXApGdCcy9IjbPDzsX/jX1FgkqAeNoShwcXgaM70gDE0a0y02/szvVh8/m
         cynzoeH+3kDucBjvnGzohIimRD2XweDbsXEHYgTxMuCF2l+gl54ds0TP/Jbqo4wmBYF7
         +4aaHWrzHO5p41tHHHfcpvehOmzZ873TGIoeU7QS/jCQtfxggNlp9f6l6JHYM0LJSw6U
         y/dBvnUuZk58MbxXyIChZRBPHjR+XQwi8c6Am/1n+GLThYZ1exAaNhmNhFNSk76KzhVm
         zy8g==
X-Gm-Message-State: AOAM5324azJQ1FNfb8v6BfMEVKs1/+5G3/Mk+vTkzSNSFAO+RgD6EfeY
        n2fZ/3Vclww2lgvi7T5Uu71H2w==
X-Google-Smtp-Source: ABdhPJwm2qswv0JrvcxvuPN29Q+VgK3II5mFgk6NQFlyvIyjJF4VYRoa8ZwPvXLjjp84ys9bffTTLQ==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr22555654pfi.233.1595306766376;
        Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id az13sm1270078pjb.34.2020.07.20.21.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:46:06 -0700 (PDT)
Date:   Mon, 20 Jul 2020 21:45:57 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Chi Song <Song.Chi@microsoft.com>
Cc:     David Miller <davem@davemloft.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next] net: hyperv: Add attributes to show TX
 indirection table
Message-ID: <20200720214557.0b711a3c@hermes.lan>
In-Reply-To: <HK0P153MB0275B7FFBA43843CC7B1EABB98780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0275B7FFBA43843CC7B1EABB98780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 21 Jul 2020 03:50:00 +0000
Chi Song <Song.Chi@microsoft.com> wrote:

> +static void netvsc_attrs_init(void)
> +{
> +	char buffer[4];
> +	int i;
> +
> +	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++) {
> +		sprintf(buffer, "%02u", i);
> +		dev_attr_netvsc_dev_attrs[i].attr.name =
> +			kstrdup(buffer, GFP_KERNEL);
> +		dev_attr_netvsc_dev_attrs[i].attr.mode = 0444;
> +		sysfs_attr_init(&dev_attr_netvsc_dev_attrs[i].attr);
> +
> +		dev_attr_netvsc_dev_attrs[i].show = tx_indirection_show;
> +		dev_attr_netvsc_dev_attrs[i].store = NULL;
> +		netvsc_dev_attrs[i] = &dev_attr_netvsc_dev_attrs[i].attr;
> +	}
> +	netvsc_dev_attrs[VRSS_SEND_TAB_SIZE] = NULL;
You know that last line is unnecessary. The variable is static and 
starts out as all zero.

Overall looks good.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
