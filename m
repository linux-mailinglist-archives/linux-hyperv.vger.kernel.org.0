Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BF447EB4
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhKHLTm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 06:19:42 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36635 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhKHLTm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 06:19:42 -0500
Received: by mail-wr1-f54.google.com with SMTP id s13so26228579wrb.3;
        Mon, 08 Nov 2021 03:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAoGngeqLslgA/3kKKTba4TQ1kNXOLlebbDyGtlvKPE=;
        b=CguE3NzdPw+6ZY7R6ZXviBZz1fY+5II3WLlu9qcgi3TxP2cO7Njmco6kStR+TZPZVY
         GIaYb9rb2Fd4byH5mTwB2wVdXoAzsiuX2DMb8MBNHD3dnzoIvutmH5JW8ikF8fcsVNoQ
         Wd8lOLIqW8EwF2ZxRVG6FH9BqrJgZcHFaqG0ddH8Ci34UwIwkR/LGTa7Y8BSg30SPx3h
         kyc1xr/WM2ZnkvDkPItcJlDM/eyp84CETvNUIT6BLuCJQo+mfqtEvy5FZmD+BFohVJ3d
         C9sA4rk+f/GKjVnec+8nhxQrU76cnrjvslX0FXV/FzsiyidpiHqtaE3B1Wos1Vcoe4rl
         5plA==
X-Gm-Message-State: AOAM5308Tcb+TIzZRNIoMKYCBRNr9zL9DNn3pYfJv5oA0uYeQz45gZU+
        wqTWrJ8lUpZH+pQKACZkfbg=
X-Google-Smtp-Source: ABdhPJz4uiwqSBaz4842KYQZS36h5axvx4+sGDY2PcgK5KM3jUlLOysnVpjzTFBULZ01gEclxBDz5g==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr73267802wrl.181.1636370217018;
        Mon, 08 Nov 2021 03:16:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v191sm15814053wme.36.2021.11.08.03.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:16:56 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:16:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v0 17/42] drivers: video: Check notifier registration
 return value
Message-ID: <20211108111655.52p5cdj2q7fbtkpy@liuwe-devbox-debian-v2>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-18-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101157.15189-18-bp@alien8.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 08, 2021 at 11:11:32AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org

Acked-by: Wei Liu <wei.liu@kernel.org>
