Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5096871
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHTSR6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 14:17:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43402 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTSR6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 14:17:58 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so14131919ioe.10;
        Tue, 20 Aug 2019 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIVbLoTHhF+QfQM0k2Z9ZD70ZXty3QTTjkrmQQ/1eKo=;
        b=C4cKT76jeEE6fxy/f3EgaH/gZRiLBkuceVhtyZyUMBIDUneiItUNE+LuPD2jTi79GN
         zhKo8Scx2Yyh/fIaNaRRD7iVe5GEMS4UtFONCbxBQF9TT7OFekTmHPcFb9zr3ZeigbB9
         YdH9W8tKf2T2ePD6VKiR2Y5RlmcU/cNc/WgENHqC+Ot+E/4bgwkAZ7xW2OhF6zfjT7q5
         aOVOOqY6rcRuul9RKGXeb8Wf1jwMZJjhtMS3UsSTYe6FHolY4e+dA5IwLGMUc6nr79dG
         2dw15RNNM71Nlh06g82tTBVt9tbZ+HZEBSyuqKWoEYU7lrd6DDYxrMFV9cJ/NQYRsnSi
         WsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIVbLoTHhF+QfQM0k2Z9ZD70ZXty3QTTjkrmQQ/1eKo=;
        b=NiXVRx4diBiRhPItrw/tjFhQfOQOEBE8Hucd9JvfPs/S3V8saSpQ7lMKhe4jlzA4yV
         /cmHdWxOZJTprGMf7tRwNESth5uhJh+hTL9ClCTVRzDuwr3kYVS2KoODA1yXsrNZ9Q5r
         TsD4L8mbp0e1GoE6D5/BAILhLT2Aaf6dmYqFttfgcnuB9xkrzSHUn1Isj+x0HxSU4ha5
         v/vusdk0wirMWGAKaG20YsxSr5S7vAv8YicFMXDr3vMdValT2M6SgXt7K79/WrIFWzjT
         WZpZ8qlf8zq6CY4hvK4BaeBT1/XT/u11/ZN0t8g6wTI53dsM/RxFFDnfYs0ynMiUvlPz
         iNSA==
X-Gm-Message-State: APjAAAVXXVVlEAdW57e+Vao8PouNPa6nf/3HJSNxbtwgVNoIk4+bH3OD
        1DpBRijWJXTjhBHjwIeGtg==
X-Google-Smtp-Source: APXvYqzIUUxyMlR2qKd2tlf38iOzwPuBYMuaRDdv2xwnYBUfZkJEeEGp5Wn0cUZ38xyHWr3y1JCMSQ==
X-Received: by 2002:a6b:6f0d:: with SMTP id k13mr2145479ioc.69.1566325077020;
        Tue, 20 Aug 2019 11:17:57 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id a6sm19553452ios.20.2019.08.20.11.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 11:17:56 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:17:54 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: hv: vmbus: add test attributes to debugfs
Message-ID: <20190820181754.GA23739@Test-Virtual-Machine>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
 <e055f27ffc37a9a6a756a3329a60da608db5a04f.1566266609.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e055f27ffc37a9a6a756a3329a60da608db5a04f.1566266609.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 19, 2019 at 10:44:48PM -0400, Branden Bonaby wrote:
> Expose the test parameters as part of the debugfs channel attributes.
> We will control the testing state via these attributes.
> 
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
> Changes in v2:
>  - Move test attributes to debugfs.
>  - Wrap test code under #ifdef statements.
>  - Add new documentation file under Documentation/ABI/testing.
>  - Make commit message reflect the change from from sysfs to debugfs.
>  
> 
> +		if (IS_ERR_OR_NULL(dev_root)) {
> +			pr_debug("debugfs_hyperv: %s/%s/ not created\n",
> +				 TESTING, device);
> +			return PTR_ERR(dev_root);
> +		}

Whoops, that single IS_ERR_OR_NULL shouldn't be there, it should just
be IS_ERR I'll change and resend the patch.
