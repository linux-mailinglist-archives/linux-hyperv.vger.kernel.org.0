Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA84C17AE0E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2020 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCES3K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Mar 2020 13:29:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41052 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCES3K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 13:29:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id v134so1826131lfa.8
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Mar 2020 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbDd5+msqmDyxpq6Lb6ucz4ESNTgElObbSpMaShcyms=;
        b=F3N0wZelss6cZK4QjAM8jWJ06sQQW3F4y8SDKE0irQdX19FJEsxMHK5XaReoIXNZ2x
         xAe1gUgz8okG6bAlHMI32BK/x7Gt3mMAGKYGD0lZomRxOWuvHYQhuJwNSVJvx+5ViBEs
         UALKk37VHLJG+gq7UTF61v3tIkdser14tfAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbDd5+msqmDyxpq6Lb6ucz4ESNTgElObbSpMaShcyms=;
        b=qH+RAsimm93HVcYIXotHj3Rt1tVGDWcerv4is5YYibBxYIIUg7WGnghp9SZmqHAOgL
         g0OELkuK/kWn0CaQ+JeiamRlBEuFe+W1Vp2m0ZXTBlx+XEu8Jc5Tmn6Ch0K73kEoD+Fn
         i+wU+p5G/iaykL3PXe6g8DhpGS8h9KtEsIa+UqzE+MEo7r+WLezPZILSAWSMg+py2vRf
         bZkUk3of9os5gJt0bytJSi16Rt/0EDST9xtAJJiIELJ8iNZ3YXmcUFVsdKPxouAvVB8W
         Qk7gnZr+vu7DjEau99FEskvO52MItaMAUfbG0em54PQZCdICoM8S+Rmb288h+mJgITXM
         gs6g==
X-Gm-Message-State: ANhLgQ3a1omluslio1H19EzbxXLBjfab7IfpcgPXUubp0+phLWxYcQNa
        Lfo1zB21ikzeUxUxRYfA3UZccrAxeONl3g==
X-Google-Smtp-Source: ADFU+vtpfEinzeAlsCL5DvNkMaLmXUj2CELnkj4GSSCU78GNgRGKkeuEnSjTT63rIHQyQ4VEGWD8NQ==
X-Received: by 2002:a05:6512:3e3:: with SMTP id n3mr6398912lfq.170.1583432946230;
        Thu, 05 Mar 2020 10:29:06 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x6sm15675999lfn.94.2020.03.05.10.29.04
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:29:05 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 195so7213125ljf.3
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Mar 2020 10:29:04 -0800 (PST)
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr6142302ljp.150.1583432944420;
 Thu, 05 Mar 2020 10:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20200305155901.xmstcqwutrb6s7pi@debian>
In-Reply-To: <20200305155901.xmstcqwutrb6s7pi@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Mar 2020 12:28:48 -0600
X-Gmail-Original-Message-ID: <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
Message-ID: <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.6-rc
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Sasha Levin <sashal@kernel.org>, haiyangz@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 5, 2020 at 9:59 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> This is mostly a "dry-run" attempt to sort out any wrinkles on my end.
> If I have done something stupid, let me know.

Looks fine. I generally like seeing the commits being a bit older than
these are - you seem to have applied or rebased them not all that long
before sending the pull request. I prefer seeing that they've been in
linux-next etc, but for soemthing small like this I guess it doesn't
much matter. Next time?

Also, it would generally be lovely to see signatures of the old
maintainer on the new maintainer's pgp key when transitions like this
happen, but it's not like we've really required that in the past
either. Literally just a "that would be nice"

                Linus
